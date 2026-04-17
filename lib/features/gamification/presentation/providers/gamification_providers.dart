import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/gamification_dao.dart';
import '../../../ontology/presentation/providers/substitution_providers.dart';
import '../../../ontology/data/database/database.dart';

final gamificationDaoProvider = Provider<GamificationDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return GamificationDao(db);
});

final userStatsProvider = FutureProvider<UserStat?>((ref) async {
  final dao = ref.watch(gamificationDaoProvider);
  return dao.getUserStats('local-user');
});

final muscleExperienceProvider = FutureProvider<List<MuscleExperienceData>>((ref) async {
  final dao = ref.watch(gamificationDaoProvider);
  return dao.getMuscleExperience('local-user');
});
