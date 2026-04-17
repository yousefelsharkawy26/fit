// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coaching_dao.dart';

// ignore_for_file: type=lint
mixin _$CoachingDaoMixin on DatabaseAccessor<AppDatabase> {
  $WorkoutsTable get workouts => attachedDatabase.workouts;
  $EquipmentTable get equipment => attachedDatabase.equipment;
  $MuscleRegionsTable get muscleRegions => attachedDatabase.muscleRegions;
  $ExercisesTable get exercises => attachedDatabase.exercises;
  $WorkoutExercisesTable get workoutExercises =>
      attachedDatabase.workoutExercises;
  $WorkoutSetsTable get workoutSets => attachedDatabase.workoutSets;
  $ExerciseMusclesTable get exerciseMuscles => attachedDatabase.exerciseMuscles;
  CoachingDaoManager get managers => CoachingDaoManager(this);
}

class CoachingDaoManager {
  final _$CoachingDaoMixin _db;
  CoachingDaoManager(this._db);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db.attachedDatabase, _db.workouts);
  $$EquipmentTableTableManager get equipment =>
      $$EquipmentTableTableManager(_db.attachedDatabase, _db.equipment);
  $$MuscleRegionsTableTableManager get muscleRegions =>
      $$MuscleRegionsTableTableManager(_db.attachedDatabase, _db.muscleRegions);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db.attachedDatabase, _db.exercises);
  $$WorkoutExercisesTableTableManager get workoutExercises =>
      $$WorkoutExercisesTableTableManager(
        _db.attachedDatabase,
        _db.workoutExercises,
      );
  $$WorkoutSetsTableTableManager get workoutSets =>
      $$WorkoutSetsTableTableManager(_db.attachedDatabase, _db.workoutSets);
  $$ExerciseMusclesTableTableManager get exerciseMuscles =>
      $$ExerciseMusclesTableTableManager(
        _db.attachedDatabase,
        _db.exerciseMuscles,
      );
}
