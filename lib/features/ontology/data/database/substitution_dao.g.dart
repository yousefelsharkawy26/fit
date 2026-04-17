// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'substitution_dao.dart';

// ignore_for_file: type=lint
mixin _$SubstitutionDaoMixin on DatabaseAccessor<AppDatabase> {
  $EquipmentTable get equipment => attachedDatabase.equipment;
  $MuscleRegionsTable get muscleRegions => attachedDatabase.muscleRegions;
  $ExercisesTable get exercises => attachedDatabase.exercises;
  SubstitutionDaoManager get managers => SubstitutionDaoManager(this);
}

class SubstitutionDaoManager {
  final _$SubstitutionDaoMixin _db;
  SubstitutionDaoManager(this._db);
  $$EquipmentTableTableManager get equipment =>
      $$EquipmentTableTableManager(_db.attachedDatabase, _db.equipment);
  $$MuscleRegionsTableTableManager get muscleRegions =>
      $$MuscleRegionsTableTableManager(_db.attachedDatabase, _db.muscleRegions);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db.attachedDatabase, _db.exercises);
}
