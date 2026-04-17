import 'package:flutter_test/flutter_test.dart';
import 'package:fit/features/workout/domain/services/intensity_predictor_service.dart';
import 'package:fit/features/coaching/domain/models/coaching_context.dart';

void main() {
  group('IntensityPredictorService', () {
    late IntensityPredictorService service;

    setUp(() {
      service = IntensityPredictorService();
    });

    CoachingContext createMockContext({double totalCnsFatigue = 0.5}) {
      return CoachingContext(
        weeklyVolume: [],
        movementPatternVolumes: [],
        topExercises: [
          PerformanceSnapshot(
            exerciseName: 'Bench Press',
            oneRepMaxEstimate: 100.0,
            weeklyTrend: 0.0,
          ),
        ],
        activeInjuries: [],
        fatigueScores: const {},
        cardioSessions: [],
        totalCnsFatigue: totalCnsFatigue,
        cnsLoadTrend: [],
      );
    }

    test('Baseline prediction (no readiness score)', () {
      final context = createMockContext();
      final target = service.predictTarget('Bench Press', context);

      // Baseline is 75% of 100kg = 75kg
      expect(target.weight, 75.0);
      expect(target.reps, 8);
    });

    test('Deload prediction when Fatigued (Score < 40)', () {
      final context = createMockContext();
      final target = service.predictTarget('Bench Press', context, readinessScore: 35.0);

      // 20% Deload logic: 75kg * 0.8 = 60kg
      expect(target.weight, 60.0);
      expect(target.reps, 12);
      expect(target.rationale, contains('ADAPTIVE DELOAD'));
    });

    test('Intensity boost when Optimal (Score > 85)', () {
      final context = createMockContext();
      // Increase trend first to allow boost (service checks snapshot.weeklyTrend >= 0)
      final target = service.predictTarget('Bench Press', context, readinessScore: 90.0);

      // 5% boost logic: 75kg * 1.05 = 78.75 -> rounded to 77.5 or 80 depending on rounding
      // (78.75 / 2.5).round() * 2.5 = 31.5 -> 32 * 2.5 = 80
      expect(target.weight, 80.0);
      expect(target.reps, 8);
      expect(target.rationale, contains('PEAK PERFORMANCE'));
    });

    test('Fallback to localized fatigue deload if readiness is missing', () {
      final context = CoachingContext(
        weeklyVolume: [],
        movementPatternVolumes: [],
        topExercises: [
          PerformanceSnapshot(exerciseName: 'Bench Press', oneRepMaxEstimate: 100, weeklyTrend: 0),
        ],
        activeInjuries: [],
        fatigueScores: const {'Chest': 0.9}, // High localized fatigue
        cardioSessions: [],
        totalCnsFatigue: 0.5,
        cnsLoadTrend: [],
      );

      final target = service.predictTarget('Bench Press', context, readinessScore: null);

      // Localized deload: 75kg * 0.9 = 67.5
      expect(target.weight, 67.5);
      expect(target.reps, 12);
    });
  });
}
