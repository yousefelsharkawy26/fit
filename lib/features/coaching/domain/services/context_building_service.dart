import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../ontology/data/database/exercise_dao.dart';
import '../../../ontology/domain/enums/ontology_enums.dart';
import '../../../ontology/presentation/providers/substitution_providers.dart';
import '../../../health/data/database/health_dao.dart';
import '../models/coaching_context.dart';
import '../../data/database/coaching_dao.dart';

final contextBuildingServiceProvider = Provider<ContextBuildingService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final coachingDao = db.coachingDao;
  final exerciseDao = ref.watch(exerciseDaoProvider);
  final healthDao = db.healthDao;
  return ContextBuildingService(coachingDao, exerciseDao, healthDao);
});

class ContextBuildingService {
  final CoachingDao _coachingDao;
  final ExerciseDao _exerciseDao;
  final HealthDao _healthDao;

  ContextBuildingService(this._coachingDao, this._exerciseDao, this._healthDao);

  /// Builds a snapshot of the user's current training state for the AI Coach.
  Future<CoachingContext> buildContext(String userId) async {
    // 1. Fetch weekly volume per muscle
    final volume = await _coachingDao.getWeeklyMuscleVolume(userId);

    // 2. Fetch active injuries (Module D transition)
    final constraints = await _exerciseDao.getActiveMuscleConstraints(userId);
    final activeInjuries = constraints
        .where((c) => c.status == MuscleConstraintStatus.injured)
        .map((c) => c.muscleId) // We'd ideally join to get names, but IDs work for logic
        .toList();

    // 3. Simple Fatigue Calculation
    // Logic: If volume > 15 sets in a week for a muscle, score it high
    final fatigueScores = <String, double>{};
    for (var v in volume) {
      double score = v.volume / 20.0; // Normalized against a high-volume cap of 20 sets
      fatigueScores[v.muscleName] = score.clamp(0.0, 1.0);
    }

    final cardioSessions = await _coachingDao
        .getWeeklyCardioSessions(userId);
    final strengthCnsFatigue = fatigueScores.isEmpty
        ? 0.0
        : fatigueScores.values.reduce((a, b) => a + b) / fatigueScores.length;

    // 4. Fetch latest wearable health snapshot (P1 Health Sync)
    final healthRow = await _healthDao.getLatestSnapshot(userId);
    final double? hrvMs = healthRow?.hrvMs;
    final int? restingHr = healthRow?.restingHr;
    final double? sleepScore = healthRow?.sleepScore;

    // 5. Compute upgraded CNS fatigue (3-factor model)
    final totalCnsFatigue = computeTotalCnsFatigue(
      strengthCnsFatigue: strengthCnsFatigue,
      cardioSessions: cardioSessions,
      hrvMs: hrvMs,
      restingHr: restingHr,
      sleepScore: sleepScore,
    );

    // 6. Performance Trend Analysis
    final topExercises = await _coachingDao.getRecentTopExercises(userId);

    // ═══ V2 Biomechanical HUD Integrations ═══
    final movementPatternVolumes = await _coachingDao.getWeeklyMovementPatternVolumes(userId);
    final cnsLoadTrend = await _coachingDao.getWeeklyCnsLoad(userId);

    return CoachingContext(
      weeklyVolume: volume,
      movementPatternVolumes: movementPatternVolumes,
      topExercises: topExercises,
      activeInjuries: activeInjuries,
      fatigueScores: fatigueScores,
      cardioSessions: cardioSessions,
      totalCnsFatigue: totalCnsFatigue,
      cnsLoadTrend: cnsLoadTrend,
      hrvMs: hrvMs,
      restingHr: restingHr,
      sleepScore: sleepScore,
    );
  }

  /// V2 CNS Fatigue Model — 3-factor weighted average.
  ///
  /// When wearable data is available:
  ///   `total = strength * 0.5 + cardio * 0.2 + wearable * 0.3`
  ///
  /// When no wearable data exists (graceful degradation to V1):
  ///   `total = strength * 0.7 + cardio * 0.3`
  ///
  /// The wearable factor is an average of all available bio-signals:
  ///   - HRV: < 30ms = exhausted, > 80ms = recovered
  ///   - RHR: > 75bpm = fatigued, < 55bpm = recovered (athlete norm)
  ///   - Sleep: 0.0 = no sleep, 1.0 = perfect sleep (inverted to fatigue)
  static double computeTotalCnsFatigue({
    required double strengthCnsFatigue,
    required List<CardioSessionMetric> cardioSessions,
    double? hrvMs,
    int? restingHr,
    double? sleepScore,
  }) {
    // ═══ Cardio factor (unchanged from V1) ═══
    double cardioFatigue = 0.0;
    
    for (final session in cardioSessions) {
      if (session.duration > 0) {
        int hr = session.heartRate > 0 ? session.heartRate : 130;
        double multiplier;
        if (hr <= 120) {
          multiplier = 1.0;
        } else if (hr <= 150) {
          multiplier = 1.0 + ((hr - 120) / 30.0) * 2.0;
        } else {
          multiplier = 3.0 + ((hr - 150) / 30.0) * 15.0;
        }
        cardioFatigue += session.duration * 0.0000277 * multiplier;
      } else if (session.distance > 0) {
        cardioFatigue += session.distance / 20000.0;
      }
    }
    
    cardioFatigue = cardioFatigue.clamp(0.0, 1.0);

    // ═══ Wearable factor (V2 — P1 Health Sync) ═══
    double wearableFatigue = 0.0;
    int signals = 0;

    if (hrvMs != null) {
      // HRV < 20ms → fatigue = 1.0, HRV > 100ms → fatigue = 0.0
      wearableFatigue += (1.0 - ((hrvMs - 20) / 80.0)).clamp(0.0, 1.0);
      signals++;
    }
    if (restingHr != null) {
      // RHR 45bpm → fatigue = 0.0, RHR 85bpm → fatigue = 1.0
      wearableFatigue += ((restingHr - 45) / 40.0).clamp(0.0, 1.0);
      signals++;
    }
    if (sleepScore != null) {
      // Invert: low sleep quality = high fatigue
      wearableFatigue += (1.0 - sleepScore).clamp(0.0, 1.0);
      signals++;
    }

    if (signals > 0) {
      wearableFatigue /= signals; // Average available signals
      // V2: 3-factor weighted model
      return (strengthCnsFatigue * 0.5 + cardioFatigue * 0.2 + wearableFatigue * 0.3)
          .clamp(0.0, 1.0);
    } else {
      // Graceful degradation: no wearable data → V1 formula
      return (strengthCnsFatigue * 0.7 + cardioFatigue * 0.3).clamp(0.0, 1.0);
    }
  }
}
