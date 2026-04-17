import 'dart:math';
import 'package:fit/features/ontology/presentation/providers/substitution_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../data/database/gamification_dao.dart';
import '../../../ontology/data/database/database.dart';
import '../../../ontology/data/database/exercise_dao.dart';
import '../../presentation/providers/gamification_providers.dart';
import '../models/gamification_events.dart';
import 'gamification_notification_service.dart';

final levelingEngineProvider = Provider<LevelingEngine>((ref) {
  return LevelingEngine(
    gamificationDao: ref.read(gamificationDaoProvider),
    exerciseDao: ref.read(exerciseDaoProvider),
    notificationService: ref.read(gamificationNotificationProvider.notifier),
  );
});

class LevelingEngine {
  final GamificationDao _gamificationDao;
  final ExerciseDao _exerciseDao;
  final GamificationNotificationService _notificationService;

  LevelingEngine({
    required GamificationDao gamificationDao,
    required ExerciseDao exerciseDao,
    required GamificationNotificationService notificationService,
  }) : _gamificationDao = gamificationDao,
       _exerciseDao = exerciseDao,
       _notificationService = notificationService;

  /// Processes a finished workout and distributes XP to muscle regions.
  Future<void> processWorkoutXP(
    String userId,
    String workoutId,
    List<WorkoutExercise> exercises,
    List<WorkoutSet> sets,
  ) async {
    final Map<String, double> muscleXPMap = {};

    for (final exercise in exercises) {
      // Find muscle regions for this exercise
      final exerciseModel = await _exerciseDao.getExerciseById(
        exercise.exerciseId,
      );
      final regions = exerciseModel?.muscles ?? [];
      final exerciseSets = sets
          .where((s) => s.workoutExerciseId == exercise.id)
          .toList();

      double exerciseVolume = 0;
      for (final set in exerciseSets) {
        // Simple Volume Load calculation
        final volume = (set.weight ?? 1) * (set.reps ?? 1);
        // RPE Multiplier (7=1.0, 8=1.2, 9=1.4, 10=1.6)
        final effectiveRpe = set.rpe ?? 7.0;
        final rpeMultiplier = 1.0 + ((effectiveRpe - 7).clamp(0, 3) * 0.2);
        exerciseVolume += volume * rpeMultiplier;

        if (set.isPr == true && exerciseModel != null) {
          _notificationService.addEvent(
            PrAchievementEvent(
              exerciseName: exerciseModel.name,
              weight: set.weight ?? 1,
              reps: set.reps ?? 1,
            ),
          );
        }
      }

      // Distribute XP across affected muscle regions
      // Primary muscles get 100%, secondary might get less, but for now let's assume all linked regions take equal share of volume as XP
      for (final junction in regions) {
        final regionId = junction.muscle.id;
        muscleXPMap[regionId] =
            (muscleXPMap[regionId] ?? 0) +
            (exerciseVolume / 10); // Scale down XP
      }
    }

    // Update Database
    for (final entry in muscleXPMap.entries) {
      await _applyXPToMuscle(userId, entry.key, entry.value.toInt());
    }

    // Also update global XP
    final totalWorkoutXP = muscleXPMap.values
        .fold(0.0, (sum, val) => sum + val)
        .toInt();
    await _applyGlobalXP(userId, totalWorkoutXP);
  }

  Future<void> _applyXPToMuscle(
    String userId,
    String regionId,
    int xpGained,
  ) async {
    final experience = await _gamificationDao.getMuscleExperience(userId);
    final current = experience.firstWhere(
      (e) => e.muscleRegionId == regionId,
      orElse: () => MuscleExperienceData(
        userId: userId,
        muscleRegionId: regionId,
        xp: 0,
        level: 1,
      ),
    );

    final newXp = current.xp + xpGained;
    final newLevel = _calculateLevelFromXP(newXp);

    if (newLevel > current.level) {
      _notificationService.addEvent(
        MuscleLevelUpEvent(muscleRegionId: regionId, newLevel: newLevel),
      );
    }

    await _gamificationDao.upsertMuscleExperience(
      MuscleExperienceCompanion(
        userId: Value(userId),
        muscleRegionId: Value(regionId),
        xp: Value(newXp),
        level: Value(newLevel),
      ),
    );
  }

  Future<void> _applyGlobalXP(String userId, int xpGained) async {
    final stats = await _gamificationDao.getUserStats(userId);
    if (stats == null) return;

    final newXp = stats.totalXp + xpGained;
    final newLevel = _calculateLevelFromXP(newXp);

    await _gamificationDao.upsertUserStats(
      stats
          .toCompanion(false)
          .copyWith(totalXp: Value(newXp), level: Value(newLevel)),
    );
  }

  /// RPG Leveling Formula: Level = Floor(Sqrt(XP / 100)) + 1
  /// Level 1: 0 XP
  /// Level 2: 100 XP
  /// Level 3: 400 XP
  /// Level 4: 900 XP
  /// Level 10: 8100 XP
  int _calculateLevelFromXP(int xp) {
    if (xp <= 0) return 1;
    return (sqrt(xp / 100).floor()) + 1;
  }
}
