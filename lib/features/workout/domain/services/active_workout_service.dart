import 'dart:async';
import 'package:fit/features/ontology/domain/enums/ontology_enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/database/workout_dao.dart';
import '../../../ontology/data/database/database.dart';
import '../../../ontology/data/database/exercise_dao.dart';
import '../../../ontology/domain/models/ontology_models.dart';
import '../../../coaching/data/database/coaching_tables.dart';
import '../../../ontology/presentation/providers/substitution_providers.dart';
import '../models/set_log_payload.dart';

import '../../../gamification/domain/services/retention_service.dart';
import '../../../gamification/domain/services/leveling_engine.dart';

sealed class LogSetResult {
  const LogSetResult();
}

class LogSetSuccess extends LogSetResult {
  final WorkoutSet setEntry;
  const LogSetSuccess(this.setEntry);
}

class LogSetWarning extends LogSetResult {
  final InjuryWarning warning;
  const LogSetWarning(this.warning);
}

final activeWorkoutServiceProvider = Provider<ActiveWorkoutService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ActiveWorkoutService(
    workoutDao: db.workoutDao,
    exerciseDao: db.exerciseDao,
    retentionService: ref.read(retentionServiceProvider),
    levelingEngine: ref.read(levelingEngineProvider),
  );
});

class ActiveWorkoutService {
  final WorkoutDao workoutDao;
  final ExerciseDao exerciseDao;
  final RetentionService retentionService;
  final LevelingEngine levelingEngine;
  final Uuid uuid = const Uuid();

  final StreamController<InjuryWarning> _warningController = StreamController<InjuryWarning>.broadcast();
  Stream<InjuryWarning> get warningStream => _warningController.stream;

  ActiveWorkoutService({
    required this.workoutDao,
    required this.exerciseDao,
    required this.retentionService,
    required this.levelingEngine,
  });

  /// Initializes a new workout session for a user.
  Future<Workout> startWorkout(String userId, {String? name}) async {
    // Check for existing active workout
    final existing = await workoutDao.getActiveWorkout(userId);
    if (existing != null) return existing;

    final workout = Workout(
      id: uuid.v4(),
      userId: userId,
      name: name,
      status: WorkoutStatus.active,
      startedAt: DateTime.now(),
      volumeLoad: 0,
      createdAt: DateTime.now(),
    );

    await workoutDao.createWorkout(workout);
    return workout;
  }

  /// Adds an exercise to the current workout.
  Future<WorkoutExercise> addExercise(
    String workoutId,
    String exerciseId,
    int orderIndex,
  ) async {
    final entry = WorkoutExercise(
      id: uuid.v4(),
      workoutId: workoutId,
      exerciseId: exerciseId,
      orderIndex: orderIndex,
      createdAt: DateTime.now(),
    );
    await workoutDao.addExerciseToWorkout(entry);
    return entry;
  }

  /// Logs a set for a specific exercise in the workout.
  Future<LogSetResult> logSet({
    required String workoutExerciseId,
    required SetLogPayload payload,
  }) async {
    // 1. Preflight Injury Check
    final workoutEx = await workoutDao.getWorkoutExerciseById(workoutExerciseId);
    if (workoutEx == null) {
      throw Exception('Workout exercise not found for ID $workoutExerciseId');
    }
    
    final workout = await workoutDao.getWorkoutById(workoutEx.workoutId);
    if (workout == null) {
      throw Exception('Active workout not found for ID ${workoutEx.workoutId}');
    }

    final exercise = await exerciseDao.getExerciseById(workoutEx.exerciseId);
    if (exercise == null) {
      throw Exception('Exercise definition not found for ID ${workoutEx.exerciseId}');
    }

    final constraints = await exerciseDao.getActiveMuscleConstraints(workout.userId);
    final now = DateTime.now();
    final injuredMuscles = constraints
        .where((c) => c.status == MuscleConstraintStatus.injured && 
                      (c.expiresAt == null || c.expiresAt!.isAfter(now)))
        .map((c) => c.muscleId)
        .toSet();

    final hitsInjured = exercise.muscles.where((m) => injuredMuscles.contains(m.muscle.id)).toList();
    if (hitsInjured.isNotEmpty) {
      final warning = InjuryWarning(
        exerciseId: exercise.id,
        exerciseName: exercise.name,
        muscleName: hitsInjured.first.muscle.name,
      );
      _warningController.add(warning);
      return LogSetWarning(warning);
    }

    if (!payload.hasRequiredFields()) {
      throw Exception('Missing required fields for ${payload.scheme.name}.');
    }

    final entry = WorkoutSet(
      id: uuid.v4(),
      workoutExerciseId: workoutExerciseId,
      weight: payload.weight ?? 0.0,
      reps: payload.reps ?? 0,
      rpe: payload.rpe,
      setType: payload.setType,
      trackingType: payload.trackingType,
      distance: payload.distance,
      duration: payload.duration,
      heartRate: payload.heartRate,
      isPr: false, // Will be updated by PR detection logic in future
      createdAt: DateTime.now(),
    );
    await workoutDao.addSetToExercise(entry);
    return LogSetSuccess(entry);
  }

  /// Updates streak after workout
  /// Finalizes the workout session and calculates the total volume.
  Future<void> finishWorkout(String workoutId) async {
    // 1. Mark as completed in DB
    await workoutDao.completeWorkout(workoutId, 0.0);

    // 2. Fetch workout data for gamification
    final workout = await workoutDao.getWorkoutById(workoutId);
    if (workout == null) return;

    final exercises = await workoutDao.getExercisesForWorkout(workoutId);
    final allSets = <WorkoutSet>[];
    
    for (final ex in exercises) {
      final sets = await workoutDao.getSetsForExercise(ex.id);
      allSets.addAll(sets);
    }

    // 3. Process Gamification (XP & Levels)
    await levelingEngine.processWorkoutXP(
      workout.userId,
      workout.id,
      exercises,
      allSets,
    );

    // 4. Update Streak
    await retentionService.updateStreakAfterWorkout(workout.userId);
  }

  /// Atomically swaps an exercise mid-workout and adds a historical note.
  Future<void> swapExercise(String workoutExerciseId, String newExerciseId, String originalName) async {
    final notes = 'Performed previous sets as $originalName';
    await workoutDao.atomicSwapExercise(workoutExerciseId, newExerciseId, notes);
  }

  Future<void> deleteSet(String setId) async {
    await workoutDao.deleteSet(setId);
  }

  Future<void> removeExercise(String workoutExerciseId) async {
    await workoutDao.deleteExerciseFromWorkout(workoutExerciseId);
  }
}
