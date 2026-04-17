// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_dao.dart';

// ignore_for_file: type=lint
mixin _$GamificationDaoMixin on DatabaseAccessor<AppDatabase> {
  $UserStatsTable get userStats => attachedDatabase.userStats;
  $MuscleExperienceTable get muscleExperience =>
      attachedDatabase.muscleExperience;
  GamificationDaoManager get managers => GamificationDaoManager(this);
}

class GamificationDaoManager {
  final _$GamificationDaoMixin _db;
  GamificationDaoManager(this._db);
  $$UserStatsTableTableManager get userStats =>
      $$UserStatsTableTableManager(_db.attachedDatabase, _db.userStats);
  $$MuscleExperienceTableTableManager get muscleExperience =>
      $$MuscleExperienceTableTableManager(
        _db.attachedDatabase,
        _db.muscleExperience,
      );
}
