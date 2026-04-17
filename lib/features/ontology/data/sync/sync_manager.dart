import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/flywheel_sync_service.dart';

/// Provider for the background Sync Manager.
///
/// The SyncManager is now a thin orchestrator that delegates all
/// actual sync processing to [FlywheelSyncService]. It exists as
/// the app-level lifecycle hook — initialized once at startup.
final syncManagerProvider = Provider<SyncManager>((ref) {
  final service = ref.watch(flywheelSyncServiceProvider);
  final manager = SyncManager(service);
  ref.onDispose(manager.dispose);
  return manager;
});

/// Thin lifecycle wrapper around [FlywheelSyncService].
///
/// Responsibilities:
/// - Start/stop the background sync loop
/// - Start/stop the realtime promotion listener
/// - Expose a manual trigger for immediate sync
class SyncManager {
  final FlywheelSyncService _service;
  bool _isInitialized = false;

  SyncManager(this._service);

  /// Initialize the background sync engine.
  /// Call this once during app startup (e.g., in main.dart).
  void initialize() {
    if (_isInitialized) return;
    _service.initialize();
    _isInitialized = true;
  }

  /// Trigger an immediate sync of all pending tasks.
  Future<void> syncNow() => _service.syncPendingTasks();

  /// Stop all background processing.
  void dispose() {
    _service.dispose();
    _isInitialized = false;
  }
}
