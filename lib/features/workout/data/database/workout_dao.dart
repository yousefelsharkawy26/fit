import 'package:drift/drift.dart';
import 'package:fit/features/ontology/data/database/database.dart';
import 'package:fit/features/coaching/data/database/coaching_tables.dart';

part 'workout_dao.g.dart';

@DriftAccessor(tables: [Workouts, WorkoutExercises, WorkoutSets])
class WorkoutDao extends DatabaseAccessor<AppDatabase> with _$WorkoutDaoMixin {
  WorkoutDao(super.db);

  // Table getters derived from the main database
  @override
  $WorkoutsTable get workouts => attachedDatabase.workouts;
  @override
  $WorkoutExercisesTable get workoutExercises => attachedDatabase.workoutExercises;
  @override
  $WorkoutSetsTable get workoutSets => attachedDatabase.workoutSets;

  /// Starts a new workout session.
  Future<void> createWorkout(Workout entry) => into(workouts).insert(
        WorkoutsCompanion.insert(
          id: entry.id,
          userId: entry.userId,
          name: Value(entry.name),
          status: entry.status,
          startedAt: Value(entry.startedAt),
          completedAt: Value(entry.completedAt),
          volumeLoad: Value(entry.volumeLoad),
          createdAt: Value(entry.createdAt),
        ),
      );

  /// Adds a new exercise instance to an active workout.
  Future<void> addExerciseToWorkout(WorkoutExercise entry) =>
      into(workoutExercises).insert(
        WorkoutExercisesCompanion.insert(
          id: entry.id,
          workoutId: entry.workoutId,
          exerciseId: entry.exerciseId,
          notes: Value(entry.notes),
          orderIndex: entry.orderIndex,
          createdAt: Value(entry.createdAt),
        ),
      );

  /// Records a completed set.
  Future<void> addSetToExercise(WorkoutSet entry) => into(workoutSets).insert(
        WorkoutSetsCompanion.insert(
          id: entry.id,
          workoutExerciseId: entry.workoutExerciseId,
          setType: entry.setType,
          weight: Value(entry.weight),
          reps: Value(entry.reps),
          rpe: Value(entry.rpe),
          trackingType: Value(entry.trackingType),
          distance: Value(entry.distance),
          duration: Value(entry.duration),
          heartRate: Value(entry.heartRate),
          isPr: Value(entry.isPr),
          restSeconds: Value(entry.restSeconds),
          createdAt: Value(entry.createdAt),
        ),
      );

  /// Updates an existing set (e.g., editing reps/weight mid-session).
  Future<void> updateSet(WorkoutSet entry) => update(workoutSets).replace(entry);

  /// Deletes a set.
  Future<void> deleteSet(String setId) => (delete(workoutSets)..where((t) => t.id.equals(setId))).go();

  /// Removes an exercise instance from workout (cascades sets).
  Future<void> deleteExerciseFromWorkout(String workoutExerciseId) =>
      (delete(workoutExercises)..where((t) => t.id.equals(workoutExerciseId))).go();

  /// Finalizes a workout session.
  Future<void> completeWorkout(String workoutId, double volume) {
    return (update(workouts)..where((t) => t.id.equals(workoutId))).write(
      WorkoutsCompanion(
        status: const Value(WorkoutStatus.completed),
        completedAt: Value(DateTime.now()),
        volumeLoad: Value(volume),
      ),
    );
  }

  /// Fetches an active workout for the user if it exists.
  Future<Workout?> getActiveWorkout(String userId) {
    return (select(workouts)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.status.equalsValue(WorkoutStatus.active))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Streams all exercises and sets for a specific workout.
  Stream<List<TypedWorkoutExercise>> watchWorkoutDetails(String workoutId) {
    // This is a complex join to get exercises and their associated sets
    return select(workoutExercises).join([
      innerJoin(workoutSets, workoutSets.workoutExerciseId.equalsExp(workoutExercises.id)),
    ]).watch().map((rows) {
      // Grouping logic would be handled in the service/provider for easier UI consumption
      return rows.map((row) {
        return TypedWorkoutExercise(
          exercise: row.readTable(workoutExercises),
          set: row.readTable(workoutSets),
        );
      }).toList();
    });
  }

  Future<Workout?> getWorkoutById(String id) {
    return (select(workouts)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<WorkoutExercise>> getExercisesForWorkout(String workoutId) {
    return (select(workoutExercises)..where((t) => t.workoutId.equals(workoutId))).get();
  }

  Future<List<WorkoutSet>> getSetsForExercise(String workoutExerciseId) {
    return (select(workoutSets)..where((t) => t.workoutExerciseId.equals(workoutExerciseId))).get();
  }

  Future<WorkoutExercise?> getWorkoutExerciseById(String id) {
    return (select(workoutExercises)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Performs an atomic swap of an exercise mid-workout, tagging historical sets.
  Future<void> atomicSwapExercise(String workoutExerciseId, String newExerciseId, String notes) async {
    return transaction(() async {
      await (update(workoutExercises)..where((t) => t.id.equals(workoutExerciseId))).write(
        WorkoutExercisesCompanion(
          exerciseId: Value(newExerciseId),
          notes: Value(notes),
        ),
      );
    });
  }
}

class TypedWorkoutExercise {
  final WorkoutExercise exercise;
  final WorkoutSet set;
  TypedWorkoutExercise({required this.exercise, required this.set});
}
