import 'package:drift/drift.dart';
import 'package:fit/features/ontology/data/database/database.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/health_snapshot.dart';
import '../../domain/models/health_sync_result.dart';
import '../../domain/repository/health_sync_repository.dart';
import '../database/health_dao.dart';

/// Fallback [HealthSyncRepository] for desktop/web development
/// and users who decline platform health permissions.
///
/// Reads and writes directly to the local [HealthDao], enabling manual
/// data entry through the [HealthManualEntrySheet] UI.
class ManualHealthRepository implements HealthSyncRepository {
  final HealthDao _dao;
  static const _uuid = Uuid();

  ManualHealthRepository(this._dao);

  @override
  Future<HealthSyncResult> requestPermissions() async {
    // Manual entry never requires permissions.
    return HealthSyncResult.success(
      HealthSnapshot(
        id: 'manual-always-granted',
        userId: '',
        syncSource: HealthSyncSource.manual,
        syncedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<HealthSnapshot?> getLatestSnapshot(String userId) async {
    final row = await _dao.getLatestSnapshot(userId);
    return row != null ? _rowToSnapshot(row) : null;
  }

  @override
  Future<List<HealthSnapshot>> getSnapshotsForRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    final rows = await _dao.getSnapshotsForRange(userId, start, end);
    return rows.map(_rowToSnapshot).toList();
  }

  @override
  Future<HealthSyncResult> syncAndPersist(String userId) async {
    // For manual mode, "sync" just returns the latest stored snapshot.
    final latest = await getLatestSnapshot(userId);
    if (latest != null) {
      return HealthSyncResult.success(latest);
    }
    // No data yet — not an error, just nothing to report.
    return const HealthSyncResult.unavailable();
  }

  /// Persists a manually entered health snapshot.
  Future<HealthSyncResult> saveManualEntry({
    required String userId,
    double? hrvMs,
    int? restingHr,
    double? sleepScore,
    int? sleepDurationMinutes,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();

    final snapshot = HealthSnapshot(
      id: id,
      userId: userId,
      hrvMs: hrvMs,
      restingHr: restingHr,
      sleepScore: sleepScore,
      sleepDurationMinutes: sleepDurationMinutes,
      syncSource: HealthSyncSource.manual,
      syncedAt: now,
      createdAt: now,
    );

    await _dao.insertSnapshot(
      HealthSnapshotsCompanion(
        id: Value(id),
        userId: Value(userId),
        hrvMs: Value(hrvMs),
        restingHr: Value(restingHr),
        sleepScore: Value(sleepScore),
        sleepDurationMinutes: Value(sleepDurationMinutes),
        syncSource: const Value('manual'),
        syncedAt: Value(now),
        createdAt: Value(now),
      ),
    );

    return HealthSyncResult.success(snapshot);
  }

  HealthSnapshot _rowToSnapshot(HealthSnapshotRow row) {
    return HealthSnapshot(
      id: row.id,
      userId: row.userId,
      hrvMs: row.hrvMs,
      restingHr: row.restingHr,
      sleepScore: row.sleepScore,
      sleepDurationMinutes: row.sleepDurationMinutes,
      syncSource: HealthSyncSource.values.byName(row.syncSource),
      syncedAt: row.syncedAt,
      createdAt: row.createdAt,
    );
  }
}
