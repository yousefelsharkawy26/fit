import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../coaching/domain/models/coaching_context.dart';

part 'analytics_models.freezed.dart';
part 'analytics_models.g.dart';

@freezed
abstract class BiomechanicalLoadSummary with _$BiomechanicalLoadSummary {
  const factory BiomechanicalLoadSummary({
    required Map<String, double> movementPatternBalance, // pattern -> volume
    required List<CnsLoadSnapshot> cnsFatigueTrend,
    required Map<String, double> muscleIntensity, // muscleId -> intensity (0.0 - 1.0+)
    required List<PerformanceTrendPoint> volumeTrend,
    required List<PerformanceTrendPoint> intensityTrend,
    required List<PerformanceSnapshot> topExercises,
    required double weeklyVolumeLoad, // Total kg moved
    required int sessionCount,
    required String recoveryStatus, // 'PRIME' | 'FATIGUED' | 'RECOVERING'
  }) = _BiomechanicalLoadSummary;

  factory BiomechanicalLoadSummary.fromJson(Map<String, dynamic> json) =>
      _$BiomechanicalLoadSummaryFromJson(json);
}

@freezed
abstract class PerformanceTrendPoint with _$PerformanceTrendPoint {
  const factory PerformanceTrendPoint({
    required DateTime date,
    required double value,
  }) = _PerformanceTrendPoint;

  factory PerformanceTrendPoint.fromJson(Map<String, dynamic> json) =>
      _$PerformanceTrendPointFromJson(json);
}
