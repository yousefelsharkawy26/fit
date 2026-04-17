import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_snapshot.freezed.dart';
part 'health_snapshot.g.dart';

/// The source platform from which health data was synced.
enum HealthSyncSource { apple, google, manual }

/// A single point-in-time snapshot of wearable health data.
///
/// Represents the user's overnight recovery signals used to
/// modulate the AI Coach's CNS Fatigue model (V2 3-factor formula).
@freezed
abstract class HealthSnapshot with _$HealthSnapshot {
  const HealthSnapshot._();

  const factory HealthSnapshot({
    required String id,
    required String userId,

    /// Heart Rate Variability (SDNN) in milliseconds.
    /// Typical athlete range: 40–100ms. Lower = more fatigued.
    double? hrvMs,

    /// Resting Heart Rate in BPM.
    /// Typical athlete range: 45–65. Higher = more fatigued.
    int? restingHr,

    /// Normalized sleep quality score (0.0 = terrible, 1.0 = perfect).
    /// Derived from sleep stage distribution + total duration.
    double? sleepScore,

    /// Total sleep duration in minutes.
    int? sleepDurationMinutes,

    /// The platform that provided this data.
    required HealthSyncSource syncSource,

    /// When the platform reported this data (e.g. "last night 6am").
    required DateTime syncedAt,

    /// When this row was inserted into the local cache.
    required DateTime createdAt,
  }) = _HealthSnapshot;

  factory HealthSnapshot.fromJson(Map<String, dynamic> json) =>
      _$HealthSnapshotFromJson(json);

  /// Data older than 6 hours is considered stale and triggers
  /// a visual warning in the dashboard + falls back in the formula.
  bool get isStale =>
      DateTime.now().difference(syncedAt) > const Duration(hours: 6);

  /// True if at least one usable bio-signal is present.
  bool get hasSignal => hrvMs != null || restingHr != null || sleepScore != null;
}
