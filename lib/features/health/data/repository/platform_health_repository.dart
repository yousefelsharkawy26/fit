import 'dart:io';

import 'package:drift/drift.dart';
import 'package:fit/features/ontology/data/database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/health_snapshot.dart';
import '../../domain/models/health_sync_result.dart';
import '../../domain/repository/health_sync_repository.dart';
import '../database/health_dao.dart';

/// Concrete [HealthSyncRepository] implementation using the `health` package.
///
/// Reads HRV, Resting HR, and Sleep data from Apple HealthKit (iOS)
/// or Google Health Connect (Android). Gracefully returns [HealthSyncResult.unavailable]
/// on unsupported platforms.
class PlatformHealthRepository implements HealthSyncRepository {
  final HealthDao _dao;
  final Health _health = Health();

  static const _uuid = Uuid();

  /// The health data types we request.
  static const _readTypes = [
    HealthDataType.HEART_RATE_VARIABILITY_SDNN,
    HealthDataType.RESTING_HEART_RATE,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_IN_BED,
  ];

  PlatformHealthRepository(this._dao);

  @override
  Future<HealthSyncResult> requestPermissions() async {
    if (!_isSupportedPlatform) {
      return const HealthSyncResult.unavailable();
    }

    try {
      final granted = await _health.requestAuthorization(
        _readTypes,
        permissions: _readTypes.map((_) => HealthDataAccess.READ).toList(),
      );
      if (!granted) {
        return const HealthSyncResult.permissionDenied();
      }
      // Return success with an empty marker snapshot
      return HealthSyncResult.success(
        HealthSnapshot(
          id: 'permission-granted',
          userId: '',
          syncSource: _platformSource,
          syncedAt: DateTime.now(),
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      debugPrint('⚠️ Health permission error: $e');
      return HealthSyncResult.error(e.toString());
    }
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
    if (!_isSupportedPlatform) {
      return const HealthSyncResult.unavailable();
    }

    try {
      // Query the last 24 hours of data
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(hours: 24));

      // Fetch all health data points
      final dataPoints = await _health.getHealthDataFromTypes(
        types: _readTypes,
        startTime: yesterday,
        endTime: now,
      );

      // Extract the most recent values for each type
      double? hrvMs;
      int? restingHr;
      double? sleepScore;
      int? sleepDurationMinutes;

      for (final point in dataPoints) {
        final value = point.value;
        switch (point.type) {
          case HealthDataType.HEART_RATE_VARIABILITY_SDNN:
            if (value is NumericHealthValue) {
              hrvMs = value.numericValue.toDouble();
            }
          case HealthDataType.RESTING_HEART_RATE:
            if (value is NumericHealthValue) {
              restingHr = value.numericValue.toInt();
            }
          case HealthDataType.SLEEP_ASLEEP:
            if (value is NumericHealthValue) {
              sleepDurationMinutes = value.numericValue.toInt();
            }
          case HealthDataType.SLEEP_IN_BED:
            // Secondary: use time-in-bed if asleep duration unavailable
            if (sleepDurationMinutes == null && value is NumericHealthValue) {
              sleepDurationMinutes = value.numericValue.toInt();
            }
          default:
            break;
        }
      }

      // Compute sleep score from duration (normalized: 480min/8hr = 1.0)
      if (sleepDurationMinutes != null && sleepDurationMinutes > 0) {
        sleepScore = (sleepDurationMinutes / 480.0).clamp(0.0, 1.0);
      }

      final snapshot = HealthSnapshot(
        id: _uuid.v4(),
        userId: userId,
        hrvMs: hrvMs,
        restingHr: restingHr,
        sleepScore: sleepScore,
        sleepDurationMinutes: sleepDurationMinutes,
        syncSource: _platformSource,
        syncedAt: now,
        createdAt: now,
      );

      // Persist to local cache
      await _dao.insertSnapshot(
        HealthSnapshotsCompanion(
          id: Value(snapshot.id),
          userId: Value(snapshot.userId),
          hrvMs: Value(snapshot.hrvMs),
          restingHr: Value(snapshot.restingHr),
          sleepScore: Value(snapshot.sleepScore),
          sleepDurationMinutes: Value(snapshot.sleepDurationMinutes),
          syncSource: Value(snapshot.syncSource.name),
          syncedAt: Value(snapshot.syncedAt),
          createdAt: Value(snapshot.createdAt),
        ),
      );

      // Housekeeping: delete snapshots older than 30 days
      await _dao.deleteStaleSnapshots(
        now.subtract(const Duration(days: 30)),
      );

      debugPrint('✅ Health sync complete: '
          'HRV=${hrvMs?.toStringAsFixed(1)}ms, '
          'RHR=$restingHr, '
          'Sleep=${sleepScore?.toStringAsFixed(2)}');

      return HealthSyncResult.success(snapshot);
    } catch (e) {
      debugPrint('❌ Health sync error: $e');
      return HealthSyncResult.error(e.toString());
    }
  }

  // ═══════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════

  bool get _isSupportedPlatform => Platform.isIOS || Platform.isAndroid;

  HealthSyncSource get _platformSource =>
      Platform.isIOS ? HealthSyncSource.apple : HealthSyncSource.google;

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
