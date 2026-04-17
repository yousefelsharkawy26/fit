import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../coaching/domain/models/coaching_context.dart';

final intensityPredictorServiceProvider = Provider<IntensityPredictorService>((
  ref,
) {
  return IntensityPredictorService();
});

class IntensityPredictorService {
  /// Predicts the target weight and reps based on historical performance and current coach context.
  SetTarget predictTarget(
    String exerciseId,
    CoachingContext context, {
    double? readinessScore,
  }) {
    // 1. Find recent performance snapshot for this exercise
    final snapshot = context.topExercises.firstWhere(
      (s) => s.exerciseName.toLowerCase().contains(exerciseId.toLowerCase()),
      orElse: () => PerformanceSnapshot(
        exerciseName: exerciseId,
        oneRepMaxEstimate: 0,
        weeklyTrend: 0,
      ),
    );

    // 2. Baseline logic: 75% of 1RM for 8 reps (Hypertrophy Default)
    double weight = snapshot.oneRepMaxEstimate * 0.75;
    int reps = 8;
    String rationale = 'Progressive overload applied based on recent gains.';

    // 3. Apply Coach Rationale/Trends
    if (snapshot.weeklyTrend > 0.05) {
      // If trend is strong, aggressive progression (+2.5kg)
      weight += 2.5;
    }

    // 4. Biological Modulation (Phase 4: Adaptive Recovery)
    if (readinessScore != null) {
      if (readinessScore < 40) {
        // FATIGUED/DANGER state: 20% Deload + Intensity Cap
        weight *= 0.8;
        reps = 12; // Higher reps, lower weight to reduce CNS tax
        rationale =
            'ADAPTIVE DELOAD: readiness ($readinessScore) is critical. Reducing intensity to preserve systemic recovery.';
      } else if (readinessScore > 85 && snapshot.weeklyTrend >= 0) {
        // OPTIMAL state: 5% intensity nudge
        weight *= 1.05;
        rationale =
            'PEAK PERFORMANCE: recovery is high. Slight intensity boost applied for PR attempt.';
      }
    }

    // 5. Safety Hard-Stops (Localized Fatigue)
    final highFatigue = context.fatigueScores.values.any(
      (score) => score > 0.8,
    );
    if (highFatigue && readinessScore == null) {
      weight *= 0.9;
      reps = 12;
      rationale = 'Deloading due to high localized muscle fatigue.';
    }

    return SetTarget(
      weight: (weight / 2.5).round() * 2.5, // Round to nearest 2.5kg
      reps: reps,
      rationale: rationale,
    );
  }
}

class SetTarget {
  final double weight;
  final int reps;
  final String rationale;

  SetTarget({
    required this.weight,
    required this.reps,
    required this.rationale,
  });
}
