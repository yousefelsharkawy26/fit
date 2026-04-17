import 'package:fit/features/coaching/presentation/providers/recovery_readiness_provider.dart';
import 'package:fit/features/ontology/domain/enums/ontology_enums.dart';
import 'package:fit/features/ontology/presentation/providers/substitution_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/active_workout_service.dart';
import '../../domain/models/set_log_payload.dart';
import '../../domain/services/intensity_predictor_service.dart';
import '../../../coaching/presentation/providers/coaching_providers.dart';
import '../../../ontology/data/database/database.dart';
import '../../../ontology/domain/models/ontology_models.dart';

final gymWarningStreamProvider = StreamProvider<InjuryWarning>((ref) {
  final service = ref.watch(activeWorkoutServiceProvider);
  return service.warningStream;
});

final workoutSessionProvider =
    NotifierProvider<WorkoutSessionNotifier, WorkoutSessionState>(() {
      return WorkoutSessionNotifier();
    });

class WorkoutSessionNotifier extends Notifier<WorkoutSessionState> {
  late final ActiveWorkoutService _service;
  late final IntensityPredictorService _predictor;

  @override
  WorkoutSessionState build() {
    _service = ref.watch(activeWorkoutServiceProvider);
    _predictor = ref.watch(intensityPredictorServiceProvider);
    return WorkoutSessionState.initial();
  }

  Future<void> startWorkout(String userId) async {
    state = state.copyWith(isLoading: true);
    final workout = await _service.startWorkout(
      userId,
      name: 'AI Guided Session',
    );
    state = state.copyWith(activeWorkout: workout, isLoading: false);
  }

  Future<void> addExercise(
    String exerciseId, {
    TrackingScheme trackingScheme = TrackingScheme.weightReps,
  }) async {
    if (state.activeWorkout == null) return;

    final order = state.exercises.length;
    final entry = await _service.addExercise(
      state.activeWorkout!.id,
      exerciseId,
      order,
    );

    // Fetch exercise metadata for UI display
    final db = ref.read(appDatabaseProvider);
    final exerciseDetails = await db.exerciseDao.getExerciseById(exerciseId);

    // Predict targets immediately
    final context = await ref.read(coachingDashboardProvider.future);
    final readiness = ref.read(recoveryReadinessProvider).asData?.value;
    final target = _predictor.predictTarget(
      exerciseId,
      context.context,
      readinessScore: readiness?.score,
    );

    final sessionExercise = SessionExercise(
      exercise: entry,
      ontologyNode: exerciseDetails,
      name: exerciseDetails?.name ?? exerciseId,
      target: target,
      sets: [],
      trackingScheme: trackingScheme,
    );

    state = state.copyWith(exercises: [...state.exercises, sessionExercise]);
  }

  Future<void> logSet(String workoutExerciseId, SetLogPayload payload) async {
    final result = await _service.logSet(
      workoutExerciseId: workoutExerciseId,
      payload: payload,
    );

    if (result is LogSetWarning) {
      // Stream will emit to ui. Set is blocked.
      return;
    }

    if (result is LogSetSuccess) {
      final updatedExercises = state.exercises.map((e) {
        if (e.exercise.id == workoutExerciseId) {
          return e.copyWith(sets: [...e.sets, result.setEntry]);
        }
        return e;
      }).toList();

      state = state.copyWith(exercises: updatedExercises);
    }
  }

  Future<void> swapExercise({
    required String workoutExerciseId,
    required String newExerciseId,
  }) async {
    final index = state.exercises.indexWhere(
      (e) => e.exercise.id == workoutExerciseId,
    );
    if (index == -1) return;

    final oldExercise = state.exercises[index];
    await _service.swapExercise(
      workoutExerciseId,
      newExerciseId,
      oldExercise.name,
    );

    // Fetch exercise metadata for UI display
    final db = ref.read(appDatabaseProvider);
    final newExerciseDetails = await db.exerciseDao.getExerciseById(
      newExerciseId,
    );

    // Predict new targets
    final context = await ref.read(coachingDashboardProvider.future);
    final readiness = ref.read(recoveryReadinessProvider).asData?.value;
    final target = _predictor.predictTarget(
      newExerciseId,
      context.context,
      readinessScore: readiness?.score,
    );

    final updatedExercise = oldExercise.copyWith(
      // Drift generates copyWith which allows updating fields
      exercise: oldExercise.exercise.copyWith(exerciseId: newExerciseId),
      name: newExerciseDetails?.name ?? newExerciseId,
      target: target,
    );

    final updatedExercises = List<SessionExercise>.from(state.exercises);
    updatedExercises[index] = updatedExercise;
    state = state.copyWith(exercises: updatedExercises);
  }

  Future<void> finishWorkout() async {
    if (state.activeWorkout != null) {
      state = state.copyWith(isLoading: true);
      await _service.finishWorkout(state.activeWorkout!.id);
      state = WorkoutSessionState.initial();
    }
  }

  Future<void> removeSet({
    required String workoutExerciseId,
    required String setId,
  }) async {
    await _service.deleteSet(setId);
    final updatedExercises = state.exercises.map((e) {
      if (e.exercise.id != workoutExerciseId) return e;
      return e.copyWith(sets: e.sets.where((s) => s.id != setId).toList());
    }).toList();
    state = state.copyWith(exercises: updatedExercises);
  }

  Future<void> removeExercise(String workoutExerciseId) async {
    await _service.removeExercise(workoutExerciseId);
    state = state.copyWith(
      exercises: state.exercises
          .where((e) => e.exercise.id != workoutExerciseId)
          .toList(),
    );
  }
}

class WorkoutSessionState {
  final Workout? activeWorkout;
  final List<SessionExercise> exercises;
  final bool isLoading;

  WorkoutSessionState({
    this.activeWorkout,
    required this.exercises,
    this.isLoading = false,
  });

  factory WorkoutSessionState.initial() => WorkoutSessionState(exercises: []);

  WorkoutSessionState copyWith({
    Workout? activeWorkout,
    List<SessionExercise>? exercises,
    bool? isLoading,
  }) {
    return WorkoutSessionState(
      activeWorkout: activeWorkout ?? this.activeWorkout,
      exercises: exercises ?? this.exercises,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SessionExercise {
  final WorkoutExercise exercise;
  final Exercise? ontologyNode; // To access rich media and tags
  final String name;
  final SetTarget target;
  final List<WorkoutSet> sets;
  final TrackingScheme trackingScheme;

  SessionExercise({
    required this.exercise,
    this.ontologyNode,
    required this.name,
    required this.target,
    required this.sets,
    required this.trackingScheme,
  });

  SessionExercise copyWith({
    WorkoutExercise? exercise,
    Exercise? ontologyNode,
    String? name,
    SetTarget? target,
    List<WorkoutSet>? sets,
    TrackingScheme? trackingScheme,
  }) {
    return SessionExercise(
      exercise: exercise ?? this.exercise,
      ontologyNode: ontologyNode ?? this.ontologyNode,
      name: name ?? this.name,
      target: target ?? this.target,
      sets: sets ?? this.sets,
      trackingScheme: trackingScheme ?? this.trackingScheme,
    );
  }
}

/// Real-time biomechanical data for the active HUD.
class BiomechanicalHUDData {
  final double totalWeightedVolume;
  final double cnsLoad;
  final Map<MovementPattern, int> patternDistribution;
  final String topMuscleGroup;

  BiomechanicalHUDData({
    required this.totalWeightedVolume,
    required this.cnsLoad,
    required this.patternDistribution,
    required this.topMuscleGroup,
  });

  factory BiomechanicalHUDData.empty() => BiomechanicalHUDData(
    totalWeightedVolume: 0,
    cnsLoad: 0,
    patternDistribution: {},
    topMuscleGroup: 'N/A',
  );
}

final activeBiomechanicalHUDProvider = Provider<BiomechanicalHUDData>((ref) {
  final session = ref.watch(workoutSessionProvider);
  if (session.exercises.isEmpty) return BiomechanicalHUDData.empty();

  double totalWeighted = 0.0;
  double cns = 0.0;
  final patterns = <MovementPattern, int>{};
  final muscleVolume = <String, double>{};

  for (final ex in session.exercises) {
    if (ex.ontologyNode == null) continue;
    final setCount = ex.sets.length;
    if (setCount == 0) continue;

    // Movement Pattern
    patterns[ex.ontologyNode!.movementPattern] =
        (patterns[ex.ontologyNode!.movementPattern] ?? 0) + setCount;

    // CNS Load
    final cnsMultiplier = switch (ex.ontologyNode!.cnsCost) {
      CnsCost.high => 5.0,
      CnsCost.medium => 3.0,
      CnsCost.low => 1.0,
    };
    cns += setCount * cnsMultiplier;

    // Weighted Muscle Volume
    for (final muscle in ex.ontologyNode!.muscles) {
      final weight = muscle.role == MuscleRole.primary ? 1.0 : 0.4;
      final vol = setCount * weight;
      totalWeighted += vol;

      final group = muscle.muscle.muscleGroup;
      muscleVolume[group] = (muscleVolume[group] ?? 0) + vol;
    }
  }

  String topGroup = 'N/A';
  if (muscleVolume.isNotEmpty) {
    topGroup = muscleVolume.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  return BiomechanicalHUDData(
    totalWeightedVolume: totalWeighted,
    cnsLoad: cns,
    patternDistribution: patterns,
    topMuscleGroup: topGroup,
  );
});
