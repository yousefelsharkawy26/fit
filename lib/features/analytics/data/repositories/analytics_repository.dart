import 'package:fit/features/ontology/presentation/providers/substitution_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../coaching/data/database/coaching_dao.dart';
import '../../../ontology/data/database/database.dart';
import '../../domain/models/analytics_models.dart';
import 'package:drift/drift.dart';

final analyticsRepositoryProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AnalyticsRepository(db, db.coachingDao);
});

class AnalyticsRepository {
  final AppDatabase _db;
  final CoachingDao _coachingDao;

  AnalyticsRepository(this._db, this._coachingDao);

  Stream<BiomechanicalLoadSummary> watchLoadSummary(String userId) {
    // We watch multiple tables to trigger updates
    final trigger = _db.select(_db.workoutSets).join([
      innerJoin(_db.workoutExercises, _db.workoutExercises.id.equalsExp(_db.workoutSets.workoutExerciseId)),
      innerJoin(_db.workouts, _db.workouts.id.equalsExp(_db.workoutExercises.workoutId)),
    ]).watch();

    return trigger.asyncMap((_) async {
      return getLoadSummary(userId);
    });
  }

  Future<BiomechanicalLoadSummary> getLoadSummary(String userId) async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    // 1. Muscle Intensity (Heatmap V2: Acute vs Chronic Workload Ratio)
    final acuteResults = await _coachingDao.getMuscleVolumeForPeriod(userId, sevenDaysAgo, now);
    final chronicResults = await _coachingDao.getMuscleVolumeForPeriod(userId, thirtyDaysAgo, now);
    
    final Map<String, double> chronicMap = {};
    for (var v in chronicResults) {
      // Chronic is avg weekly volume over past 30 days (roughly 4 weeks)
      chronicMap[v.muscleName] = v.volume / 4.0;
    }

    final Map<String, double> muscleIntensity = {};
    for (var v in acuteResults) {
      final acute = v.volume;
      final chronic = chronicMap[v.muscleName] ?? 0.0;
      
      double acwr = 1.0;
      if (chronic > 0) {
        acwr = acute / chronic;
      } else if (acute > 0) {
        // Did acute work but no chronic basis
        acwr = 1.5; // Treated as high relative intensity
      } else {
        acwr = 0.0;
      }
      
      // We map acwr to 0.0 - 1.0 specifically for the heatmap interpolation
      // ACWR sweet spot: 0.8 to 1.3
      // Danger: > 1.5
      // Detraining: < 0.8
      // Let's normalize so 1.3 ACWR -> ~1.0 intensity (bright cyan)
      // and > 1.5 ACWR -> ~1.2+ intensity (red/danger via UI if we change the color mapping, or just very bright)
      muscleIntensity[v.muscleName] = (acwr / 1.5).clamp(0.0, 1.2);
    }

    // 2. Movement Pattern Balance (Performance Signature)
    final patternResults = await _coachingDao.getWeeklyMovementPatternVolumes(userId);
    final Map<String, double> movementPatternBalance = {};
    for (var p in patternResults) {
      movementPatternBalance[p.pattern] = p.volume;
    }

    // 3. CNS Fatigue Trend
    final cnsFatigueTrend = await _coachingDao.getWeeklyCnsLoad(userId);

    // 4. Volume & Intensity Trends (Last 30 days)
    final recentWorkouts = await (_db.select(_db.workouts)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.status.equals('completed'))
          ..where((t) => t.completedAt.isBiggerThanValue(thirtyDaysAgo))
          ..orderBy([(t) => OrderingTerm(expression: t.completedAt, mode: OrderingMode.asc)]))
        .get();

    final volumeTrend = recentWorkouts.map((w) => PerformanceTrendPoint(
          date: w.completedAt!,
          value: w.volumeLoad,
        )).toList();

    // 5. Top Exercises
    final topExercises = await _coachingDao.getRecentTopExercises(userId);

    // 6. Totals
    double totalVolume = 0;
    for (var w in recentWorkouts) {
      if (w.completedAt!.isAfter(sevenDaysAgo)) {
        totalVolume += w.volumeLoad;
      }
    }

    final latestCnsLoad = cnsFatigueTrend.isNotEmpty ? cnsFatigueTrend.last.load : 0.0;

    return BiomechanicalLoadSummary(
      muscleIntensity: muscleIntensity,
      movementPatternBalance: movementPatternBalance,
      cnsFatigueTrend: cnsFatigueTrend,
      volumeTrend: volumeTrend,
      intensityTrend: [],
      topExercises: topExercises,
      weeklyVolumeLoad: totalVolume,
      sessionCount: recentWorkouts.where((w) => w.completedAt!.isAfter(sevenDaysAgo)).length,
      recoveryStatus: _calculateRecoveryStatus(muscleIntensity, latestCnsLoad),
    );
  }

  String _calculateRecoveryStatus(Map<String, double> intensity, double latestCnsLoad) {
    final avgIntensity = intensity.values.isEmpty 
      ? 0.0 
      : intensity.values.reduce((a, b) => a + b) / intensity.values.length;
    
    // Recovery thresholds increased by CNS strain
    if (avgIntensity > 0.8 || latestCnsLoad > 25.0) return 'FATIGUED';
    if (avgIntensity > 0.4 || latestCnsLoad > 15.0) return 'RECOVERING';
    return 'PRIME';
  }
}
