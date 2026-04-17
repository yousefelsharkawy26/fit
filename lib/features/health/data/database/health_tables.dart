import 'package:drift/drift.dart';

/// Local health data cache — offline-first storage for wearable sync snapshots.
///
/// Each row represents a single sync event from Apple HealthKit,
/// Google Health Connect, or manual user entry.
@DataClassName('HealthSnapshotRow')
@TableIndex(
  name: 'idx_health_snapshots_user_synced',
  columns: {#userId, #syncedAt},
)
class HealthSnapshots extends Table {
  /// UUID primary key.
  TextColumn get id => text()();

  /// The user this snapshot belongs to.
  TextColumn get userId => text()();

  /// Heart Rate Variability (SDNN) in milliseconds.
  RealColumn get hrvMs => real().nullable()();

  /// Resting Heart Rate in BPM.
  IntColumn get restingHr => integer().nullable()();

  /// Normalized sleep quality (0.0–1.0).
  RealColumn get sleepScore => real().nullable()();

  /// Total sleep duration in minutes.
  IntColumn get sleepDurationMinutes => integer().nullable()();

  /// Data source: 'apple', 'google', or 'manual'.
  TextColumn get syncSource => text()();

  /// When the platform reported this data point.
  DateTimeColumn get syncedAt => dateTime()();

  /// Row insertion timestamp.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
