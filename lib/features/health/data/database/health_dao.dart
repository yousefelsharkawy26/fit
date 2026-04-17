import 'package:drift/drift.dart';
import '../../../ontology/data/database/database.dart';
import 'health_tables.dart';

part 'health_dao.g.dart';

/// Data access object for the local health data cache.
///
/// All wearable sync data flows through this DAO for persistence
/// and retrieval, ensuring offline-first operation.
@DriftAccessor(tables: [HealthSnapshots])
class HealthDao extends DatabaseAccessor<AppDatabase> with _$HealthDaoMixin {
  HealthDao(super.db);

  /// Returns the most recent health snapshot for the given user.
  Future<HealthSnapshotRow?> getLatestSnapshot(String userId) {
    return (select(healthSnapshots)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.syncedAt,
                  mode: OrderingMode.desc,
                ),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Returns snapshots within the given date range for trend analysis.
  Future<List<HealthSnapshotRow>> getSnapshotsForRange(
    String userId,
    DateTime start,
    DateTime end,
  ) {
    return (select(healthSnapshots)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.syncedAt.isBiggerOrEqualValue(start))
          ..where((t) => t.syncedAt.isSmallerOrEqualValue(end))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.syncedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
  }

  /// Inserts a new health snapshot row.
  Future<void> insertSnapshot(HealthSnapshotsCompanion entry) {
    return into(healthSnapshots).insert(entry, mode: InsertMode.insertOrReplace);
  }

  /// Deletes snapshots older than the given date (cleanup).
  Future<int> deleteStaleSnapshots(DateTime olderThan) {
    return (delete(healthSnapshots)
          ..where((t) => t.syncedAt.isSmallerThanValue(olderThan)))
        .go();
  }
}
