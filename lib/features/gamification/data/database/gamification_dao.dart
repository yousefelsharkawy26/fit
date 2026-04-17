import 'package:drift/drift.dart';
import 'gamification_tables.dart';
import '../../../ontology/data/database/database.dart';

part 'gamification_dao.g.dart';

@DriftAccessor(tables: [UserStats, MuscleExperience])
class GamificationDao extends DatabaseAccessor<AppDatabase> with _$GamificationDaoMixin {
  GamificationDao(super.db);

  // Manual table getters as we've done in other DAOs to ensure stability
  @override
  $UserStatsTable get userStats => attachedDatabase.userStats;
  
  @override
  $MuscleExperienceTable get muscleExperience => attachedDatabase.muscleExperience;

  Future<UserStat?> getUserStats(String userId) {
    return (select(userStats)..where((t) => t.userId.equals(userId))).getSingleOrNull();
  }

  Future<void> upsertUserStats(UserStatsCompanion companion) {
    return into(userStats).insertOnConflictUpdate(companion);
  }

  Future<List<MuscleExperienceData>> getMuscleExperience(String userId) {
    return (select(muscleExperience)..where((t) => t.userId.equals(userId))).get();
  }

  Future<void> upsertMuscleExperience(MuscleExperienceCompanion companion) {
    return into(muscleExperience).insertOnConflictUpdate(companion);
  }
}
