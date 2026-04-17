// Coaching context models for AI reasoning
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coaching_context.freezed.dart';
part 'coaching_context.g.dart';

@freezed
abstract class CoachingContext with _$CoachingContext {
  const factory CoachingContext({
    required List<MuscleVolume> weeklyVolume,
    required List<MovementPatternVolume> movementPatternVolumes,
    required List<PerformanceSnapshot> topExercises,
    required List<String> activeInjuries,
    required Map<String, double> fatigueScores, // MuscleRegion name -> Fatigue score
    required List<CardioSessionMetric> cardioSessions,
    required double totalCnsFatigue,
    required List<CnsLoadSnapshot> cnsLoadTrend,

    // ═══ V2: Wearable Bio-Signals (P1 Health Sync) ═══
    /// Heart Rate Variability (SDNN) in ms. Lower = more fatigued.
    double? hrvMs,
    /// Resting Heart Rate in BPM. Higher = more fatigued.
    int? restingHr,
    /// Normalized sleep quality score (0.0–1.0). Lower = more fatigued.
    double? sleepScore,
  }) = _CoachingContext;

  factory CoachingContext.fromJson(Map<String, dynamic> json) =>
      _$CoachingContextFromJson(json);
}

@freezed
abstract class PerformanceSnapshot with _$PerformanceSnapshot {
  const factory PerformanceSnapshot({
    required String exerciseName,
    required double oneRepMaxEstimate, // Calculated from weight/reps
    required double weeklyTrend, // % change compared to prior week
  }) = _PerformanceSnapshot;

  factory PerformanceSnapshot.fromJson(Map<String, dynamic> json) =>
      _$PerformanceSnapshotFromJson(json);
}

@freezed
abstract class MuscleVolume with _$MuscleVolume {
  const factory MuscleVolume({
    required String muscleName,
    required double volume, // Weighted value (1.0 for primary, 0.4 for secondary)
  }) = _MuscleVolume;

  factory MuscleVolume.fromJson(Map<String, dynamic> json) =>
      _$MuscleVolumeFromJson(json);
}

@freezed
abstract class MovementPatternVolume with _$MovementPatternVolume {
  const factory MovementPatternVolume({
    required String pattern, // e.g., 'Horizontal Push', 'Squat'
    required double volume,
  }) = _MovementPatternVolume;

  factory MovementPatternVolume.fromJson(Map<String, dynamic> json) =>
      _$MovementPatternVolumeFromJson(json);
}

@freezed
abstract class CnsLoadSnapshot with _$CnsLoadSnapshot {
  const factory CnsLoadSnapshot({
    required DateTime date,
    required double load, required DateTime timestamp,
  }) = _CnsLoadSnapshot;

  factory CnsLoadSnapshot.fromJson(Map<String, dynamic> json) =>
      _$CnsLoadSnapshotFromJson(json);
}

@freezed
abstract class CardioSessionMetric with _$CardioSessionMetric {
  const factory CardioSessionMetric({
    @Default(0.0) double distance,
    @Default(0) int duration,
    @Default(0) int heartRate,
  }) = _CardioSessionMetric;

  factory CardioSessionMetric.fromJson(Map<String, dynamic> json) =>
      _$CardioSessionMetricFromJson(json);
}
