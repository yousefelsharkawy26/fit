import '../models/overload_prescription.dart';
import '../models/recovery_readiness.dart';

class PredictiveOverloadEngine {
  /// Calculates the optimal target prescription based on history and today's readiness.
  OverloadPrescription calculatePrescription({
    required RecoveryReadiness readiness,
    required double? historical1RM,
    int targetReps = 8,
  }) {
    // 1. Discovery Edge Case: No History
    if (historical1RM == null || historical1RM <= 0) {
      return const OverloadPrescription(
        targetWeight: 0,
        targetReps: 12,
        targetRpe: 6.0,
        rationaleNote: 'Discovery: Start light to calibrate your baseline.',
        isDiscovery: true,
      );
    }

    // 2. Base Weight Calculation via Inverted Epley
    // Weight = 1RM / (1 + (Reps / 30.0))
    final baseWeight = historical1RM / (1.0 + (targetReps / 30.0));

    // 3. Multipliers based on Recovery Level
    double targetWeight = baseWeight;
    double targetRpe = 8.0;
    String note = '';

    switch (readiness.level) {
      case RecoveryLevel.optimal:
        targetWeight = baseWeight * 1.025; // 2.5% PR Overload
        targetRpe = 8.5;
        note = 'Optimal execution window. Pushing for a 2.5% PR overload.';
        break;
      case RecoveryLevel.recovered:
        targetWeight = baseWeight * 1.0;
        targetRpe = 8.0;
        note = 'System recovered. Matching historical intensity equivalent.';
        break;
      case RecoveryLevel.restoring:
        targetWeight = baseWeight * 0.90; // 10% Deload
        targetRpe = 7.0;
        note = 'Slight systemic fatigue. Active 10% intensity deload prescribed.';
        break;
      case RecoveryLevel.fatigued:
      case RecoveryLevel.danger:
        targetWeight = baseWeight * 0.80; // 20% Deload
        targetRpe = 6.0;
        note = 'High fatigue detected. Max 80% intensity. Consider skipping if soreness persists.';
        break;
    }

    // 4. Fractional Plates Rounding Strategy (round to nearest 2.5)
    final roundedWeight = _roundToFractionalPlate(targetWeight);

    return OverloadPrescription(
      targetWeight: roundedWeight,
      targetReps: targetReps,
      targetRpe: targetRpe,
      rationaleNote: note,
    );
  }

  /// Rounds the calculated optimal weight to the nearest 2.5 increment (e.g. 5lb / 2.5kg standard plates).
  double _roundToFractionalPlate(double weight) {
    const fraction = 2.5;
    return (weight / fraction).round() * fraction;
  }
}
