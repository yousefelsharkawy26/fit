import 'package:flutter_test/flutter_test.dart';
import 'package:fit/features/coaching/domain/services/recovery_synthesis_service.dart';
import 'package:fit/features/coaching/domain/models/coaching_context.dart';
import 'package:fit/features/coaching/presentation/providers/coaching_providers.dart';
import 'package:fit/features/health/domain/models/health_snapshot.dart';
import 'package:fit/features/coaching/domain/services/split_auditor_service.dart';
import 'package:fit/features/coaching/domain/models/recovery_readiness.dart';

void main() {
  group('RecoverySynthesisService', () {
    late RecoverySynthesisService service;

    setUp(() {
      service = RecoverySynthesisService();
    });

    CoachingDashboardState createMockState({
      double currentFatigue = 0.5,
      List<double> history = const [0.5, 0.5, 0.5],
    }) {
      return CoachingDashboardState(
        context: CoachingContext(
          weeklyVolume: [],
          movementPatternVolumes: [],
          topExercises: [],
          activeInjuries: [],
          fatigueScores: const {},
          cardioSessions: [],
          totalCnsFatigue: currentFatigue,
          cnsLoadTrend: history
              .map(
                (l) => CnsLoadSnapshot(
                  date: DateTime.now(),
                  timestamp: DateTime.now(),
                  load: l,
                ),
              )
              .toList(),
        ),
        auditReport: AuditReport(isBalanced: true, issues: [], suggestions: []),
      );
    }

    test('Optimal recovery synthesize high HRV and good sleep', () {
      final state = createMockState(
        currentFatigue: 0.4,
        history: [0.5, 0.5, 0.5],
      );
      final health = HealthSnapshot(
        id: 'test-health',
        userId: 'local-user',
        syncedAt: DateTime.now(),
        createdAt: DateTime.now(),
        syncSource: HealthSyncSource.manual,
        hrvMs: 65, // Above baseline 55
        restingHr: 50,
        sleepScore: 0.9,
      );

      final result = service.calculateReadiness(state, health);

      expect(result.level, RecoveryLevel.optimal);
      expect(result.score, greaterThan(85));
    });

    test('Fatigued state due to low HRV and high recent load', () {
      final state = createMockState(
        currentFatigue: 1.6,
        history: [1.0, 1.0, 1.0],
      ); // 1.6 ratio
      final health = HealthSnapshot(
        id: 'test-health-fatigue',
        userId: 'local-user',
        syncedAt: DateTime.now(),
        createdAt: DateTime.now(),
        syncSource: HealthSyncSource.manual,
        hrvMs: 40, // Below baseline 55
        restingHr: 65,
        sleepScore: 0.7,
      );

      final result = service.calculateReadiness(state, health);

      expect(result.level, RecoveryLevel.fatigued);
      expect(result.score, lessThan(45));
    });

    test('Danger state: critical exhaustion indicators', () {
      final state = createMockState(
        currentFatigue: 2.5,
        history: [1.0, 1.0, 1.0],
      ); // Extreme load
      final health = HealthSnapshot(
        id: 'test-health-danger',
        userId: 'local-user',
        syncedAt: DateTime.now(),
        createdAt: DateTime.now(),
        syncSource: HealthSyncSource.manual,
        hrvMs: 30, // Very low HRV
        restingHr: 70,
        sleepScore: 0.3, // Poor sleep
      );

      final result = service.calculateReadiness(state, health);

      expect(result.level, RecoveryLevel.danger);
      expect(result.score, lessThan(25));
    });

    test('Null health snapshot uses default neutral factors', () {
      final state = createMockState(
        currentFatigue: 0.5,
        history: [0.5, 0.5, 0.5],
      );

      final result = service.calculateReadiness(state, null);

      expect(result.level, isNotNull);
      // Neutral factors (1.0 each) should yield approx 97 score (since HRV max is 1.25, but 1.0 is used here)
      // Actually 100 * 0.3 + 100 * 0.4 + 90 * 0.3 = 30 + 40 + 27 = 97
      expect(result.score, closeTo(97, 1.0));
    });
  });
}
