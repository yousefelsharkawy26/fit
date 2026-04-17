import 'dart:typed_data';
import 'package:fit/features/ontology/data/database/substitution_dao.dart';

import '../enums/ontology_enums.dart';
import '../models/ontology_models.dart';
import '../../data/database/exercise_dao.dart';
import '../../data/repository/vector_repository.dart';
import '../../data/vectorizer/vector_compute_service.dart';

/// Unifies the 3-stage substitution pipeline.
///
/// Stage 1: Pre-filter candidates based on hard constraints (SQL)
/// Stage 2: Vector Similarity search against remaining candidates (sqlite-vec)
/// Stage 3: Exclude user-rejected substitutions (Feedback Loop)
///
/// See: exercise_ontology_design.md §5.3 — 3-Stage Query Pipeline
class SubstitutionService {
  final ExerciseDao exerciseDao;
  final SubstitutionDao substitutionDao;
  final VectorRepository vectorRepo;
  final VectorComputeService computeService;

  SubstitutionService(
    this.exerciseDao,
    this.substitutionDao,
    this.vectorRepo,
    this.computeService,
  );

  /// Find alternatives for a given exercise.
  Future<List<SubstitutionResult>> findSubstitutions({
    required Exercise sourceExercise,
    required String currentUserId,
    SubstitutionConstraints constraints = SubstitutionConstraints.empty,
    int limit = 5,
  }) async {
    // 1. Fetch User Personalization Data
    final activeConstraints = await exerciseDao.getActiveMuscleConstraints(
      currentUserId,
    );
    final userPrefs = await exerciseDao.getExercisePreferences(currentUserId);
    final rejectedIds = await exerciseDao.getRejectedExerciseIds(
      userId: currentUserId,
      sourceExerciseId: sourceExercise.id,
    );

    // Identify injured muscles for the pre-filter
    final injuredMuscleIds = activeConstraints
        .where((c) => c.status == MuscleConstraintStatus.injured)
        .map((c) => c.muscleId)
        .toList();

    // Identify blacklisted exercise IDs
    final blacklistedIds = userPrefs
        .where((p) => p.isBlacklisted)
        .map((p) => p.exerciseId)
        .toList();

    // Merge all exclusion IDs (Hard Rejections + Active Rejections + Blacklist)
    final allExcludeIds = <String>{
      ...rejectedIds,
      if (constraints.excludeExerciseIds != null)
        ...constraints.excludeExerciseIds!,
      ...blacklistedIds,
    }.toList();

    // Update constraints with context-aware data
    final contextualConstraints = SubstitutionConstraints(
      excludeEquipmentIds: constraints.excludeEquipmentIds,
      requireLaterality: constraints.requireLaterality,
      excludeLoadingType: constraints.excludeLoadingType,
      maxSkillLevel: constraints.maxSkillLevel,
      excludeExerciseIds: allExcludeIds,
      injuredMuscleIds: injuredMuscleIds,
    );

    // 2. Generate target vector
    final targetVector = await computeService.compute(sourceExercise);

    // 3. Execute Pipeline (Stage 1 & 2)
    List<SubstitutionResult> results = await _executePipeline(
      targetVector: targetVector,
      constraints: contextualConstraints,
      rejectedIds: allExcludeIds,
      limit: limit,
      constraintsRelaxed: false,
    );

    // 4. Fallback logic: if no results, progressively relax constraints
    if (results.isEmpty && contextualConstraints.hasConstraints) {
      results = await _relaxConstraintsAndSearch(
        targetVector: targetVector,
        originalConstraints: contextualConstraints,
        rejectedIds: allExcludeIds,
        limit: limit,
      );
    }

    // 5. Stage 3: Personalization Penalty/Boost
    // Adjust scores based on user_preferences
    for (var i = 0; i < results.length; i++) {
      final res = results[i];
      final pref = userPrefs.firstWhere(
        (p) => p.exerciseId == res.exercise.id,
        orElse: () =>
            const ExercisePreference(exerciseId: '', preferenceScore: 1.0),
      );

      if (pref.preferenceScore != 1.0) {
        // Apply the multiplier. Note: similarityPercent is derived from score.
        // We adjust the underlying score (distance).
        // If multiplier > 1.0 (Favorite), we want SMALLER distance.
        // If multiplier < 1.0 (Dislike), we want LARGER distance.
        final adjustedScore = (res.score / pref.preferenceScore).clamp(
          0.0,
          2.0,
        );
        results[i] = SubstitutionResult(
          exercise: res.exercise,
          score: adjustedScore,
          constraintsRelaxed: res.constraintsRelaxed,
          relaxedConstraints: res.relaxedConstraints,
          personalizationNote: pref.preferenceScore > 1.0
              ? 'Ranked higher based on your favorites'
              : 'Ranked lower based on past dislikes',
        );
      }
    }

    // Sort again as multipliers may have shifted the ranking
    results.sort((a, b) => a.score.compareTo(b.score));

    // Remove the source exercise itself if it slipped in
    results.removeWhere((r) => r.exercise.id == sourceExercise.id);

    return results;
  }

  /// Core pipeline execution using the SQL Vector Join (Approach 1)
  Future<List<SubstitutionResult>> _executePipeline({
    required Float32List targetVector,
    required SubstitutionConstraints constraints,
    required List<String> rejectedIds,
    required int limit,
    required bool constraintsRelaxed,
    List<String> relaxedKeys = const [],
  }) async {
    // Stage 1 & 2 combined: SQL Vector Join with strict safety/equipment bottlenecks
    try {
      final vectorMatches = await substitutionDao.getFilteredSubstitutions(
        originalExerciseId: '', // Ideally we pass the source ID here, but in the pipeline we already excluded it via rejectedIds
        targetVector: targetVector,
        excludedEquipmentIds: constraints.excludeEquipmentIds ?? [],
        excludedExerciseIds: rejectedIds,
        limit: limit + 1,
      );

      final results = <SubstitutionResult>[];
      for (final match in vectorMatches) {
        // Enforce the remaining Dart-side constraints (Laterality, LoadingType, SkillLevel)
        if (_matchesConstraints(match.key, constraints, skipEquipment: true)) {
          results.add(
            SubstitutionResult(
              exercise: match.key,
              score: match.value,
              constraintsRelaxed: constraintsRelaxed,
              relaxedConstraints: relaxedKeys,
            ),
          );
        }
      }
      return results;
    } catch (e) {
      // ⚠️ FALLBACK: If vector search failed (e.g. extension missing) but we have candidates,
      // return the first batch of matching exercises with a default score.
      final allExercises = await exerciseDao.getAllExercises();
      final candidateIds = allExercises
          .where((e) => _matchesConstraints(e, constraints, skipEquipment: false))
          .map((e) => e.id)
          .toList();

      final fallbackLimit = limit.clamp(0, candidateIds.length);
      final results = <SubstitutionResult>[];
      for (var i = 0; i < fallbackLimit; i++) {
        final exercise = await exerciseDao.getExerciseById(candidateIds[i]);
        if (exercise != null) {
          results.add(
            SubstitutionResult(
              exercise: exercise,
              score: 0.9 + (i * 0.01), // Slightly increasing distance
              constraintsRelaxed: constraintsRelaxed,
              relaxedConstraints: relaxedKeys,
            ),
          );
        }
      }
      return results;
    }
  }

  /// Evaluates an exercise against hard constraints.
  bool _matchesConstraints(
    Exercise exercise,
    SubstitutionConstraints constraints, {
    bool skipEquipment = false, // Added to avoid checking equipment again if the SQL query handled it
  }) {
    if (!skipEquipment && constraints.excludeEquipmentIds != null &&
        constraints.excludeEquipmentIds!.contains(exercise.equipment.id)) {
      return false;
    }
    if (constraints.requireLaterality != null &&
        exercise.laterality != constraints.requireLaterality) {
      return false;
    }
    if (constraints.excludeLoadingType != null &&
        exercise.loadingType == constraints.excludeLoadingType) {
      return false;
    }
    if (constraints.maxSkillLevel != null &&
        exercise.skillLevel.index > constraints.maxSkillLevel!.index) {
      return false;
    }

    // 5. Injury Hard-Stop: Exclude exercises hitting injured muscles
    if (constraints.injuredMuscleIds?.isNotEmpty ?? false) {
      final hitsInjured = exercise.muscles.any(
        (m) => constraints.injuredMuscleIds!.contains(m.muscle.id),
      );
      if (hitsInjured) return false;
    }

    return true;
  }

  /// Hierarchy of constraint relaxation per the design doc.
  Future<List<SubstitutionResult>> _relaxConstraintsAndSearch({
    required Float32List targetVector,
    required SubstitutionConstraints originalConstraints,
    required List<String> rejectedIds,
    required int limit,
  }) async {
    // Attempt 1: Drop skill level
    if (originalConstraints.maxSkillLevel != null) {
      final relaxed = SubstitutionConstraints(
        excludeEquipmentIds: originalConstraints.excludeEquipmentIds,
        requireLaterality: originalConstraints.requireLaterality,
        excludeLoadingType: originalConstraints.excludeLoadingType,
        maxSkillLevel: null,
      );
      final results = await _executePipeline(
        targetVector: targetVector,
        constraints: relaxed,
        rejectedIds: rejectedIds,
        limit: limit,
        constraintsRelaxed: true,
        relaxedKeys: ['Skill Level Allowed (Advanced)'],
      );
      if (results.isNotEmpty) return results;
    }

    // Attempt 2: Drop laterality (e.g. Unilateral constraint relaxed)
    if (originalConstraints.requireLaterality != null) {
      final relaxed = SubstitutionConstraints(
        excludeEquipmentIds: originalConstraints.excludeEquipmentIds,
        requireLaterality: null,
        excludeLoadingType: originalConstraints.excludeLoadingType,
        maxSkillLevel: null,
      );
      final results = await _executePipeline(
        targetVector: targetVector,
        constraints: relaxed,
        rejectedIds: rejectedIds,
        limit: limit,
        constraintsRelaxed: true,
        relaxedKeys: ['Laterality requirement relaxed'],
      );
      if (results.isNotEmpty) return results;
    }

    // Return empty if even stripped down constraints fail
    return [];
  }
}
