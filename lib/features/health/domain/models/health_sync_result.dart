import 'health_snapshot.dart';

/// Sealed result type for health sync operations.
///
/// Provides exhaustive matching for all possible outcomes of a
/// platform health data request — success, denied, unavailable, or error.
sealed class HealthSyncResult {
  const HealthSyncResult();

  /// Data was successfully synced and persisted.
  const factory HealthSyncResult.success(HealthSnapshot snapshot) =
      HealthSyncSuccess;

  /// User declined health data permissions.
  const factory HealthSyncResult.permissionDenied() =
      HealthSyncPermissionDenied;

  /// Platform doesn't support health data (e.g. Windows, Web, Linux).
  const factory HealthSyncResult.unavailable() = HealthSyncUnavailable;

  /// An unexpected error occurred during sync.
  const factory HealthSyncResult.error(String message) = HealthSyncError;
}

class HealthSyncSuccess extends HealthSyncResult {
  final HealthSnapshot snapshot;
  const HealthSyncSuccess(this.snapshot);
}

class HealthSyncPermissionDenied extends HealthSyncResult {
  const HealthSyncPermissionDenied();
}

class HealthSyncUnavailable extends HealthSyncResult {
  const HealthSyncUnavailable();
}

class HealthSyncError extends HealthSyncResult {
  final String message;
  const HealthSyncError(this.message);
}
