import 'package:fit/features/coaching/domain/services/context_building_service.dart';
import 'package:fit/features/coaching/domain/models/coaching_context.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContextBuildingService.computeTotalCnsFatigue — V2 (Wearable)', () {
    // ═══════════════════════════════════════════════════════
    // BACKWARD COMPATIBILITY: null wearable → V1 formula
    // ═══════════════════════════════════════════════════════

    test('No wearable data → V1 formula (strength * 0.7 + cardio * 0.3)', () {
      final total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.8,
        cardioSessions: [],
        // All wearable params null → V1 path
      );

      // V1: 0.8 * 0.7 + 0.0 * 0.3 = 0.56
      expect(total, closeTo(0.56, 0.0001));
    });

    // ═══════════════════════════════════════════════════════
    // SINGLE SIGNAL TESTS
    // ═══════════════════════════════════════════════════════

    test('HRV only: 80ms (well recovered) → lower fatigue than V1 baseline', () {
      final v1Total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.5,
        cardioSessions: [],
      );
      final v2Total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.5,
        cardioSessions: [],
        hrvMs: 80.0, // Well recovered
      );

      // HRV 80ms → fatigue = (1.0 - (80-20)/80) = (1.0 - 0.75) = 0.25
      // V2: 0.5*0.5 + 0.0*0.2 + 0.25*0.3 = 0.25 + 0.075 = 0.325
      expect(v2Total, closeTo(0.325, 0.001));
      expect(v2Total, lessThan(v1Total));
    });

    test('HRV only: 25ms (exhausted) → higher fatigue than V1 baseline', () {
      final v1Total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.5,
        cardioSessions: [],
      );
      final v2Total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.5,
        cardioSessions: [],
        hrvMs: 25.0, // Exhausted
      );

      // HRV 25ms → fatigue = (1.0 - (25-20)/80) = (1.0 - 0.0625) = 0.9375
      // V2: 0.5*0.5 + 0.0*0.2 + 0.9375*0.3 = 0.25 + 0.28125 = 0.53125
      expect(v2Total, closeTo(0.53125, 0.001));
      expect(v2Total, greaterThan(v1Total));
    });

    // ═══════════════════════════════════════════════════════
    // ALL THREE SIGNALS
    // ═══════════════════════════════════════════════════════

    test('All 3 signals (good recovery) → pulls total fatigue down', () {
      final v1Total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.6,
        cardioSessions: [],
      );
      final v2Total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.6,
        cardioSessions: [],
        hrvMs: 75.0,      // Good
        restingHr: 50,     // Athletic
        sleepScore: 0.9,   // Great sleep
      );

      // HRV: (1 - (75-20)/80) = (1 - 0.6875) = 0.3125
      // RHR: (50-45)/40 = 0.125
      // Sleep: 1 - 0.9 = 0.1
      // Avg: (0.3125 + 0.125 + 0.1) / 3 = 0.1792
      // V2: 0.6*0.5 + 0.0*0.2 + 0.1792*0.3 = 0.3 + 0.05375 = 0.35375
      expect(v2Total, closeTo(0.3538, 0.01));
      expect(v2Total, lessThan(v1Total));
    });

    test('All 3 signals (poor recovery) → pushes total fatigue up', () {
      final v1Total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.4,
        cardioSessions: [],
      );
      final v2Total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.4,
        cardioSessions: [],
        hrvMs: 22.0,      // Very low
        restingHr: 80,     // Elevated
        sleepScore: 0.2,   // Bad sleep
      );

      // HRV: (1 - (22-20)/80) = (1 - 0.025) = 0.975
      // RHR: (80-45)/40 = 0.875
      // Sleep: 1 - 0.2 = 0.8
      // Avg: (0.975 + 0.875 + 0.8) / 3 = 0.8833
      // V2: 0.4*0.5 + 0.0*0.2 + 0.8833*0.3 = 0.2 + 0.265 = 0.465
      expect(v2Total, closeTo(0.465, 0.01));
      expect(v2Total, greaterThan(v1Total));
    });

    // ═══════════════════════════════════════════════════════
    // EDGE CASES
    // ═══════════════════════════════════════════════════════

    test('Sleep score 0.0 (no sleep) → max wearable fatigue from sleep alone', () {
      final total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.5,
        cardioSessions: [],
        sleepScore: 0.0, // Zero sleep
      );

      // Sleep fatigue = 1 - 0.0 = 1.0
      // V2: 0.5*0.5 + 0.0*0.2 + 1.0*0.3 = 0.25 + 0.3 = 0.55
      expect(total, closeTo(0.55, 0.001));
    });

    test('Extreme values never exceed 1.0 (clamp)', () {
      final total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 1.0,
        cardioSessions: [
          const CardioSessionMetric(distance: 50000),
        ],
        hrvMs: 5.0,       // Critically low
        restingHr: 100,    // Very high
        sleepScore: 0.0,   // No sleep
      );

      expect(total, lessThanOrEqualTo(1.0));
      expect(total, greaterThan(0.8)); // Should be very high fatigue
    });
  });
}
