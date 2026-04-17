import 'package:fit/features/coaching/domain/services/context_building_service.dart';
import 'package:fit/features/coaching/domain/models/coaching_context.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContextBuildingService.computeTotalCnsFatigue', () {
    test('includes cardio distance into total CNS fatigue', () {
      final noCardio = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.5,
        cardioSessions: [],
      );
      final withCardio = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.5,
        cardioSessions: [CardioSessionMetric(distance: 10000)],
      );

      expect(withCardio, greaterThan(noCardio));
    });

    test('preserves strength-only baseline when cardio is zero', () {
      final total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.8,
        cardioSessions: [],
      );

      expect(total, closeTo(0.56, 0.0001));
    });

    test('clamps high cardio distance contribution', () {
      final total = ContextBuildingService.computeTotalCnsFatigue(
        strengthCnsFatigue: 0.9,
        cardioSessions: [CardioSessionMetric(distance: 50000)],
      );

      expect(total, lessThanOrEqualTo(1.0));
      expect(total, closeTo(0.93, 0.0001));
    });
  });
}
