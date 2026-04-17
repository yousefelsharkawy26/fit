import 'dart:convert';
import 'package:drift/drift.dart';

import '../../domain/enums/ontology_enums.dart';
import 'database.dart';
import '../../domain/models/ontology_models.dart';
import 'ontology_tables.dart';

part 'exercise_dao.g.dart';

/// Data Access Object for exercise CRUD and query operations.
///
/// All read operations return fully hydrated domain models
/// (with resolved muscles, aliases, and equipment).
///
/// See: exercise_ontology_design.md §4 — Database Schema
@DriftAccessor(
  tables: [
    Exercises,
    ExerciseMuscles,
    ExerciseAliases,
    MuscleRegions,
    Equipment,
    SubstitutionFeedback,
    SyncQueue,
    UserPreferences,
    UserMuscleConstraints,
  ],
)
class ExerciseDao extends DatabaseAccessor<AppDatabase>
    with _$ExerciseDaoMixin {
  ExerciseDao(super.db);

  // ═══════════════════════════════════════════════════════
  //  READ — Single Exercise (fully hydrated)
  // ═══════════════════════════════════════════════════════

  /// Get a single exercise by ID with all relationships resolved.
  Future<Exercise?> getExerciseById(String id) async {
    final exerciseRow = await (select(
      exercises,
    )..where((e) => e.id.equals(id))).getSingleOrNull();

    if (exerciseRow == null) return null;

    return _hydrateExercise(exerciseRow);
  }

  // ═══════════════════════════════════════════════════════
  //  READ — All Exercises (with optional filters)
  // ═══════════════════════════════════════════════════════

  /// Get all exercises, optionally filtered by tier, muscle group, or equipment.
  Future<List<Exercise>> getAllExercises({
    int? tier,
    String? muscleGroup,
    String? equipmentId,
    String? movementPattern,
  }) async {
    var query = select(exercises).join([
      if (muscleGroup != null) ...[
        innerJoin(
          exerciseMuscles,
          exerciseMuscles.exerciseId.equalsExp(exercises.id),
        ),
        innerJoin(
          muscleRegions,
          muscleRegions.id.equalsExp(exerciseMuscles.muscleId) &
              muscleRegions.muscleGroup.equals(muscleGroup),
        ),
      ],
    ]);

    if (tier != null) {
      query = query..where(exercises.tier.equals(tier));
    }
    if (equipmentId != null) {
      query = query..where(exercises.equipmentId.equals(equipmentId));
    }
    if (movementPattern != null) {
      query = query..where(exercises.movementPattern.equals(movementPattern));
    }

    final rows = await query.get();

    // Deduplicate (joins can produce duplicates when filtering by muscle group)
    final uniqueIds = <String>{};
    final uniqueRows = <TypedResult>[];
    for (final row in rows) {
      final id = row.readTable(exercises).id;
      if (uniqueIds.add(id)) {
        uniqueRows.add(row);
      }
    }

    final results = <Exercise>[];
    for (final row in uniqueRows) {
      final exerciseRow = row.readTable(exercises);
      final hydrated = await _hydrateExercise(exerciseRow);
      results.add(hydrated);
    }

    return results;
  }

  // ═══════════════════════════════════════════════════════
  //  READ — Search by Name or Alias
  // ═══════════════════════════════════════════════════════

  /// Search exercises by name or alias (case-insensitive partial match).
  /// Returns unique exercises matching the query across both the
  /// exercises.name column and the exercise_aliases.alias_name column.
  Future<List<Exercise>> searchByName(String query) async {
    final pattern = '%${query.toLowerCase()}%';

    // Search in exercises table
    final directResults = await (select(
      exercises,
    )..where((e) => e.name.lower().like(pattern))).get();

    // Search in aliases table
    final aliasResults = await (select(
      exerciseAliases,
    )..where((a) => a.aliasName.lower().like(pattern))).get();

    // Collect unique exercise IDs
    final exerciseIds = <String>{
      ...directResults.map((e) => e.id),
      ...aliasResults.map((a) => a.exerciseId),
    };

    // Hydrate each unique exercise
    final results = <Exercise>[];
    for (final id in exerciseIds) {
      final exercise = await getExerciseById(id);
      if (exercise != null) {
        results.add(exercise);
      }
    }

    return results;
  }

  // ═══════════════════════════════════════════════════════
  //  READ — Muscle Regions
  // ═══════════════════════════════════════════════════════

  /// Get all muscle regions, ordered by display_order.
  Future<List<MuscleRegion>> getAllMuscleRegions() async {
    final rows = await (select(
      muscleRegions,
    )..orderBy([(t) => OrderingTerm.asc(t.displayOrder)])).get();

    return rows
        .map(
          (r) => MuscleRegion(
            id: r.id,
            name: r.name,
            muscleGroup: r.muscleGroup,
            displayOrder: r.displayOrder,
          ),
        )
        .toList();
  }

  /// Get all muscle regions grouped by muscle group.
  Future<Map<String, List<MuscleRegion>>> getMuscleRegionsByGroup() async {
    final all = await getAllMuscleRegions();
    final grouped = <String, List<MuscleRegion>>{};
    for (final region in all) {
      grouped.putIfAbsent(region.muscleGroup, () => []).add(region);
    }
    return grouped;
  }

  // ═══════════════════════════════════════════════════════
  //  READ — Equipment
  // ═══════════════════════════════════════════════════════

  /// Get all equipment types.
  Future<List<EquipmentModel>> getAllEquipment() async {
    final rows = await select(equipment).get();
    return rows
        .map((r) => EquipmentModel(id: r.id, name: r.name, icon: r.icon))
        .toList();
  }

  // ═══════════════════════════════════════════════════════
  //  WRITE — Exercise CRUD
  // ═══════════════════════════════════════════════════════

  /// Insert a new exercise with its muscle junctions and aliases.
  Future<void> insertExercise({
    required ExercisesCompanion exercise,
    required List<ExerciseMusclesCompanion> muscles,
    required List<ExerciseAliasesCompanion> aliases,
  }) async {
    await transaction(() async {
      await into(exercises).insert(exercise);
      for (final muscle in muscles) {
        await into(exerciseMuscles).insert(muscle);
      }
      for (final alias in aliases) {
        await into(exerciseAliases).insert(alias);
      }
    });
  }

  /// Update an exercise's metadata (e.g., after AI inference).
  Future<void> updateExercise(
    String exerciseId,
    ExercisesCompanion updates,
  ) async {
    await (update(
      exercises,
    )..where((e) => e.id.equals(exerciseId))).write(updates);
  }

  /// Delete an exercise and all related data (cascade).
  Future<void> deleteExercise(String exerciseId) async {
    await transaction(() async {
      await (delete(
        exerciseMuscles,
      )..where((em) => em.exerciseId.equals(exerciseId))).go();
      await (delete(
        exerciseAliases,
      )..where((ea) => ea.exerciseId.equals(exerciseId))).go();
      await (delete(exercises)..where((e) => e.id.equals(exerciseId))).go();
    });
  }

  /// Insert a single exercise alias (useful for Library Merge)
  Future<void> insertAlias(ExerciseAliasesCompanion alias) async {
    await into(exerciseAliases).insert(alias);
  }

  // ═══════════════════════════════════════════════════════
  //  WRITE — Substitution Feedback
  // ═══════════════════════════════════════════════════════

  /// Record a user's rejection of a substitution suggestion.
  Future<void> rejectSubstitution({
    required String id,
    required String userId,
    required String sourceExerciseId,
    required String rejectedExerciseId,
  }) async {
    await transaction(() async {
      await into(substitutionFeedback).insertOnConflictUpdate(
        SubstitutionFeedbackCompanion.insert(
          id: id,
          userId: userId,
          sourceExerciseId: sourceExerciseId,
          rejectedExerciseId: rejectedExerciseId,
          createdAt: DateTime.now().toUtc().toIso8601String(),
        ),
      );

      // Enqueue to the Data Flywheel for global consensus scoring
      await enqueueSyncAction(
        id: 'sync-rej-${DateTime.now().millisecondsSinceEpoch}',
        action: SyncAction.reportFlywheel,
        payload: jsonEncode({
          'user_id': userId,
          'source_exercise_id': sourceExerciseId,
          'rejected_exercise_id': rejectedExerciseId,
        }),
      );
    });
  }

  /// Get all rejected exercise IDs for a given source exercise and user.
  Future<List<String>> getRejectedExerciseIds({
    required String userId,
    required String sourceExerciseId,
  }) async {
    final rows =
        await (select(substitutionFeedback)..where(
              (sf) =>
                  sf.userId.equals(userId) &
                  sf.sourceExerciseId.equals(sourceExerciseId),
            ))
            .get();

    return rows.map((r) => r.rejectedExerciseId).toList();
  }

  // ═══════════════════════════════════════════════════════
  //  SYNC — Global Flywheel
  // ═══════════════════════════════════════════════════════

  /// Enqueue a background sync task.
  Future<void> enqueueSyncAction({
    required String id,
    required SyncAction action,
    required String payload,
  }) async {
    await into(syncQueue).insertOnConflictUpdate(
      SyncQueueCompanion.insert(
        id: id,
        action: action,
        payload: payload,
        status: const Value(SyncStatus.pending),
        createdAt: DateTime.now().toUtc().toIso8601String(),
      ),
    );
  }

  /// Get sync tasks that are waiting to be processed.
  Future<List<SyncQueueData>> getPendingSyncTasks() async {
    return await (select(syncQueue)
          ..where((t) => t.status.equalsValue(SyncStatus.pending))
          ..orderBy([(q) => OrderingTerm.asc(q.createdAt)])
          ..limit(50))
        .get();
  }

  /// Update the status of a sync task.
  Future<void> updateSyncStatus(
    String id,
    SyncStatus status, {
    String? error,
    DateTime? processedAt,
  }) async {
    await (update(syncQueue)..where((t) => t.id.equals(id))).write(
      SyncQueueCompanion(
        status: Value(status),
        lastError: Value(error),
        processedAt: Value(processedAt?.toUtc().toIso8601String()),
        updatedAt: Value(DateTime.now().toUtc().toIso8601String()),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  //  PERSONALIZATION — Constraints & Preferences
  // ═══════════════════════════════════════════════════════

  /// Get all active (non-expired) muscle constraints for a user.
  Future<List<MuscleConstraint>> getActiveMuscleConstraints(
    String userId,
  ) async {
    final now = DateTime.now().toUtc().toIso8601String();

    final rows = await (select(userMuscleConstraints)
          ..where((u) =>
              u.userId.equals(userId) &
              (u.expiresAt.isNull() | u.expiresAt.isBiggerThanValue(now))))
        .get();

    return rows
        .map(
          (r) => MuscleConstraint(
            muscleId: r.muscleId,
            status: r.status,
            expiresAt: r.expiresAt != null ? DateTime.parse(r.expiresAt!) : null,
          ),
        )
        .toList();
  }

  /// Watch active (non-expired) muscle constraints for a user.
  Stream<List<MuscleConstraint>> watchActiveMuscleConstraints(String userId) {
    final now = DateTime.now().toUtc().toIso8601String();

    return (select(userMuscleConstraints)
          ..where((u) =>
              u.userId.equals(userId) &
              (u.expiresAt.isNull() | u.expiresAt.isBiggerThanValue(now))))
        .watch()
        .map((rows) => rows
            .map(
              (r) => MuscleConstraint(
                muscleId: r.muscleId,
                status: r.status,
                expiresAt: r.expiresAt != null ? DateTime.parse(r.expiresAt!) : null,
              ),
            )
            .toList());
  }

  /// Save or update a muscle constraint.
  Future<void> saveMuscleConstraint(
    UserMuscleConstraintsCompanion entry,
  ) async {
    await into(userMuscleConstraints).insertOnConflictUpdate(entry);
  }

  /// Remove a constraint for a specific muscle.
  Future<void> removeMuscleConstraint(String userId, String muscleId) async {
    await (delete(userMuscleConstraints)
          ..where((u) => u.userId.equals(userId) & u.muscleId.equals(muscleId)))
        .go();
  }

  /// Get exercise preferences for a user.
  Future<List<ExercisePreference>> getExercisePreferences(String userId) async {
    final rows = await (select(userPreferences)
          ..where((u) => u.userId.equals(userId)))
        .get();
    return rows
        .map(
          (r) => ExercisePreference(
            exerciseId: r.exerciseId,
            preferenceScore: r.preferenceScore,
            isBlacklisted: r.isBlacklisted,
          ),
        )
        .toList();
  }

  /// Save or update an exercise preference.
  Future<void> saveExercisePreference(UserPreferencesCompanion entry) async {
    await into(userPreferences).insertOnConflictUpdate(entry);
  }

  // ═══════════════════════════════════════════════════════
  //  PRIVATE — Hydration Helpers
  // ═══════════════════════════════════════════════════════

  /// Hydrate a raw exercise row into a full domain model
  /// by resolving equipment, muscles, and aliases.
  Future<Exercise> _hydrateExercise(ExerciseData row) async {
    // Resolve equipment
    final equipmentRow = await (select(equipment)
          ..where((e) => e.id.equals(row.equipmentId)))
        .getSingle();

    // Resolve muscles
    final muscleJunctions = await (select(exerciseMuscles)
          ..where((em) => em.exerciseId.equals(row.id)))
        .get();

    final resolvedMuscles = <ExerciseMuscle>[];
    for (final junction in muscleJunctions) {
      final muscleRow = await (select(muscleRegions)
            ..where((m) => m.id.equals(junction.muscleId)))
          .getSingle();

      resolvedMuscles.add(
        ExerciseMuscle(
          muscle: MuscleRegion(
            id: muscleRow.id,
            name: muscleRow.name,
            muscleGroup: muscleRow.muscleGroup,
            displayOrder: muscleRow.displayOrder,
          ),
          role: junction.role,
        ),
      );
    }

    // Resolve aliases
    final aliasRows = await (select(exerciseAliases)
          ..where((a) => a.exerciseId.equals(row.id)))
        .get();

    final resolvedAliases = aliasRows
        .map(
          (a) => ExerciseAlias(
            id: a.id,
            exerciseId: a.exerciseId,
            aliasName: a.aliasName,
            isPrimary: a.isPrimary,
          ),
        )
        .toList();

    return Exercise(
      id: row.id,
      name: row.name,
      primaryMuscleId: row.primaryMuscleId,
      equipment: EquipmentModel(
        id: equipmentRow.id,
        name: equipmentRow.name,
        icon: equipmentRow.icon,
      ),
      muscles: resolvedMuscles,
      aliases: resolvedAliases,
      movementPattern: row.movementPattern,
      planeOfMotion: row.planeOfMotion,
      angle: row.angle,
      laterality: row.laterality,
      loadingType: row.loadingType,
      cnsCost: row.cnsCost,
      skillLevel: row.skillLevel,
      mechanics: row.mechanics,
      lottieUrl: row.lottieUrl,
      instructions: row.instructions,
      tier: row.tier,
      confidence: row.confidence,
      canonicalHash: row.canonicalHash,
      createdBy: row.createdBy,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  /// Public wrapper for hydration (used by SubstitutionDao).
  Future<Exercise> hydrateExercise(ExerciseData row) => _hydrateExercise(row);
}
