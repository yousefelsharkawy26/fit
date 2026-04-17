import 'package:fit/features/coaching/presentation/providers/coaching_providers.dart';

import '../../domain/models/coaching_context.dart';
import '../../../health/domain/models/health_snapshot.dart';
import '../models/recovery_readiness.dart';

class RecoverySynthesisService {
  /// Synthesizes health signals and training load into a single Readiness score.
  RecoveryReadiness calculateReadiness(
    CoachingDashboardState dashboard,
    HealthSnapshot? health,
  ) {
    // Factors
    double sleepFactor = 1.0;
    double hrvFactor = 1.0;
    double loadFactor = 1.0;

    // 1. Sleep Quality (30% Weight)
    if (health?.sleepScore != null) {
      sleepFactor = health!.sleepScore!;
    }

    // 2. HRV Deviation (40% Weight)
    // Baseline is arbitrary for now (55ms) until historical trend is ready
    const hrvBaseline = 55.0;
    if (health?.hrvMs != null) {
      final ratio = health!.hrvMs! / hrvBaseline;
      hrvFactor = ratio.clamp(0.0, 1.25); // Cap at 1.25 for excessive recovery
    }

    // 3. Training Load Balance (30% Weight)
    final currentLoad = dashboard.context.totalCnsFatigue;
    final avgLoad = _calculateAvgCnsLoad(dashboard.context.cnsLoadTrend);

    if (avgLoad > 0) {
      final ratio = currentLoad / avgLoad;
      if (ratio > 1.5) {
        loadFactor = 0.3;
      } else if (ratio > 1.2) {
        loadFactor = 0.6;
      } else if (ratio < 0.5) {
        loadFactor = 1.0; // Rested
      } else {
        loadFactor = 0.9;
      }
    }

    // Weighted Synthesis
    final finalScore =
        ((sleepFactor * 30) + (hrvFactor * 40) + (loadFactor * 30)).clamp(
          0.0,
          100.0,
        );

    final level = _determineLevel(finalScore);
    final recommendation = _generateRecommendation(level, finalScore);

    return RecoveryReadiness(
      score: finalScore,
      level: level,
      recommendation: recommendation,
      factorContributions: {
        'sleep': sleepFactor,
        'hrv': hrvFactor,
        'load': loadFactor,
      },
    );
  }

  double _calculateAvgCnsLoad(List<CnsLoadSnapshot> trend) {
    if (trend.isEmpty) return 0;
    return trend.map((s) => s.load).reduce((a, b) => a + b) / trend.length;
  }

  RecoveryLevel _determineLevel(double score) {
    if (score >= 80) return RecoveryLevel.optimal;
    if (score >= 60) return RecoveryLevel.recovered;
    if (score >= 40) return RecoveryLevel.restoring;
    if (score >= 20) return RecoveryLevel.fatigued;
    return RecoveryLevel.danger;
  }

  String _generateRecommendation(RecoveryLevel level, double score) {
    switch (level) {
      case RecoveryLevel.optimal:
        return 'SYSTEMS PRIME: High CNS capacity detected. Ideal for PR attempts and intensity peaks.';
      case RecoveryLevel.recovered:
        return 'RECOVERED: Proceed with planned volume. Consistency is the primary objective today.';
      case RecoveryLevel.restoring:
        return 'RESTORING: Slight systemic fatigue. Coach recommends 10% volume reduction or sub-maximal intensity.';
      case RecoveryLevel.fatigued:
        return 'FATIGUED: Recovery markers are suppressed. Mandatory 20% intensity deload suggested to prevent injury.';
      case RecoveryLevel.danger:
        return 'CRITICAL EXHAUSTION: All biomechanical buffers exhausted. Active recovery (walking/mobility) only.';
    }
  }
}
