// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_dao.dart';

// ignore_for_file: type=lint
mixin _$ExerciseDaoMixin on DatabaseAccessor<AppDatabase> {
  $EquipmentTable get equipment => attachedDatabase.equipment;
  $MuscleRegionsTable get muscleRegions => attachedDatabase.muscleRegions;
  $ExercisesTable get exercises => attachedDatabase.exercises;
  $ExerciseMusclesTable get exerciseMuscles => attachedDatabase.exerciseMuscles;
  $ExerciseAliasesTable get exerciseAliases => attachedDatabase.exerciseAliases;
  $SubstitutionFeedbackTable get substitutionFeedback =>
      attachedDatabase.substitutionFeedback;
  $SyncQueueTable get syncQueue => attachedDatabase.syncQueue;
  $UserPreferencesTable get userPreferences => attachedDatabase.userPreferences;
  $UserMuscleConstraintsTable get userMuscleConstraints =>
      attachedDatabase.userMuscleConstraints;
  ExerciseDaoManager get managers => ExerciseDaoManager(this);
}

class ExerciseDaoManager {
  final _$ExerciseDaoMixin _db;
  ExerciseDaoManager(this._db);
  $$EquipmentTableTableManager get equipment =>
      $$EquipmentTableTableManager(_db.attachedDatabase, _db.equipment);
  $$MuscleRegionsTableTableManager get muscleRegions =>
      $$MuscleRegionsTableTableManager(_db.attachedDatabase, _db.muscleRegions);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db.attachedDatabase, _db.exercises);
  $$ExerciseMusclesTableTableManager get exerciseMuscles =>
      $$ExerciseMusclesTableTableManager(
        _db.attachedDatabase,
        _db.exerciseMuscles,
      );
  $$ExerciseAliasesTableTableManager get exerciseAliases =>
      $$ExerciseAliasesTableTableManager(
        _db.attachedDatabase,
        _db.exerciseAliases,
      );
  $$SubstitutionFeedbackTableTableManager get substitutionFeedback =>
      $$SubstitutionFeedbackTableTableManager(
        _db.attachedDatabase,
        _db.substitutionFeedback,
      );
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db.attachedDatabase, _db.syncQueue);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(
        _db.attachedDatabase,
        _db.userPreferences,
      );
  $$UserMuscleConstraintsTableTableManager get userMuscleConstraints =>
      $$UserMuscleConstraintsTableTableManager(
        _db.attachedDatabase,
        _db.userMuscleConstraints,
      );
}
