import '../models/health_snapshot.dart';
import '../models/health_sync_result.dart';

/// Platform-agnostic interface for wearable health data access.
///
/// Implementations:
/// - [PlatformHealthRepository] — Apple HealthKit / Google Health Connect
/// - [ManualHealthRepository] — Dev fallback + manual entry path
abstract class HealthSyncRepository {
  /// Requests runtime permissions for health data access.
  /// Returns [HealthSyncResult.permissionDenied] if the user declines.
  /// Returns [HealthSyncResult.unavailable] on unsupported platforms.
  Future<HealthSyncResult> requestPermissions();

  /// Fetches the most recent health snapshot from the local cache.
  /// Returns null if no data has been synced yet.
  Future<HealthSnapshot?> getLatestSnapshot(String userId);

  /// Fetches health snapshots within a date range (for trend analysis).
  Future<List<HealthSnapshot>> getSnapshotsForRange(
    String userId,
    DateTime start,
    DateTime end,
  );

  /// Performs a full sync cycle: read from platform → persist to local cache.
  /// On unsupported platforms, returns [HealthSyncResult.unavailable].
  Future<HealthSyncResult> syncAndPersist(String userId);
}
