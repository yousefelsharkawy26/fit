import 'package:flutter_test/flutter_test.dart';
import 'package:fit/features/coaching/domain/services/context_building_service.dart';
import 'package:fit/features/coaching/domain/models/coaching_context.dart';

void main() {
  group('ContextBuildingService.computeTotalCnsFatigue', () {
    test('strength-only week', () {
      final fatigue = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.8,
        cardioSessions: [],
      );
      // Expected formula: strengthCnsFatigue * 0.7 + cardioCnsFatigue * 0.3
      // Here cardio is 0, so 0.8 * 0.7 = 0.56
      expect(fatigue, closeTo(0.56, 0.01));
    });

    test('endurance cardio (low HR, high volume)', () {
      // 4 hours (14400s) of zone 2 cardio (120 bpm)
      final fatigue = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.0,
        cardioSessions: [
          CardioSessionMetric(duration: 14400, heartRate: 120),
        ],
      );
      
      // Endurance score should be moderate, around 0.4 cardio fatigue -> 0.4 * 0.3 = 0.12
      expect(fatigue, closeTo(0.12, 0.05));
    });

    test('high-intensity cardio (high HR, low volume)', () {
      // 20 mins (1200s) of HIIT (180 bpm) - high intensity
      final fatigue = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.0,
        cardioSessions: [
          CardioSessionMetric(duration: 1200, heartRate: 180),
        ],
      );
      
      // HIIT should yield a similarly high or meaningful fatigue due to intensity multiplier despite low duration
      // Say it yields 0.5 cardio fatigue -> 0.5 * 0.3 = 0.15
      expect(fatigue, closeTo(0.15, 0.05));
    });

    test('mixed modal week', () {
      // High strength fatigue + moderate cardio
      final fatigue = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.9,
        cardioSessions: [
          CardioSessionMetric(duration: 3600, heartRate: 150),
        ],
      );
      
      // Expect high combined fatigue
      // 0.9 * 0.7 = 0.63
      // 1 hr at 150 bpm -> maybe 0.3 cardio fatgue -> 0.3 * 0.3 = 0.09
      // Total approx 0.72
      expect(fatigue, closeTo(0.72, 0.05));
    });

    test('distance fallback avoids double-counting', () {
      // Same duration, one with distance, one without. 
      // Ensure distance doesn't inflate the score if duration is present. 
      final fatigueWithDistance = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.0,
        cardioSessions: [
          CardioSessionMetric(duration: 3600, distance: 10000, heartRate: 150),
        ],
      );
      
      final fatigueWithoutDistance = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.0,
        cardioSessions: [
          CardioSessionMetric(duration: 3600, distance: 0, heartRate: 150),
        ],
      );
      
      expect(fatigueWithDistance, closeTo(fatigueWithoutDistance, 0.05));
    });
    
    test('pure distance legacy support computes reasonably', () {
        // If someone only logs 10km (no time, no hr)
        final fatigue = ContextBuildingService.computeTotalCnsFatigue(
          strengthCnsFatigue: 0.0,
          cardioSessions: [
            CardioSessionMetric(distance: 10000, duration: 0, heartRate: 0),
          ],
        );
        // 10000 / 20000 = 0.5 cardio fatigue -> 0.5 * 0.3 = 0.15
        expect(fatigue, closeTo(0.15, 0.01));
    });
  });
}
