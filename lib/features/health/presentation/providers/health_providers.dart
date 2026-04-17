import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ontology/presentation/providers/substitution_providers.dart';
import '../../data/database/health_dao.dart';
import '../../data/repository/manual_health_repository.dart';
import '../../data/repository/platform_health_repository.dart';
import '../../domain/models/health_snapshot.dart';
import '../../domain/models/health_sync_result.dart';
import '../../domain/repository/health_sync_repository.dart';

// ═══════════════════════════════════════════════════════
// HEALTH DAO — sourced from the central AppDatabase
// ═══════════════════════════════════════════════════════

final healthDaoProvider = Provider<HealthDao>((ref) {
  return ref.watch(appDatabaseProvider).healthDao;
});

// ═══════════════════════════════════════════════════════
// REPOSITORY — platform-aware injection
// ═══════════════════════════════════════════════════════

/// Provides the correct [HealthSyncRepository] based on the runtime platform.
/// iOS/Android → [PlatformHealthRepository] (HealthKit / Health Connect)
/// Everything else → [ManualHealthRepository] (desktop dev / manual entry)
final healthSyncRepositoryProvider = Provider<HealthSyncRepository>((ref) {
  final dao = ref.watch(healthDaoProvider);
  if (Platform.isIOS || Platform.isAndroid) {
    return PlatformHealthRepository(dao);
  }
  return ManualHealthRepository(dao);
});

// ═══════════════════════════════════════════════════════
// LATEST SNAPSHOT — auto-refreshes on invalidation
// ═══════════════════════════════════════════════════════

/// Watches the latest health snapshot for the current user.
/// Returns null if no data has been synced yet.
final latestHealthSnapshotProvider =
    FutureProvider.autoDispose<HealthSnapshot?>((ref) async {
  final repo = ref.watch(healthSyncRepositoryProvider);
  return repo.getLatestSnapshot('local-user');
});

// ═══════════════════════════════════════════════════════
// SYNC TRIGGER — app launch + periodic refresh
// ═══════════════════════════════════════════════════════

/// Triggers a health data sync from the platform.
/// Call this on app launch and periodically (30min timer).
final healthSyncTriggerProvider =
    FutureProvider.autoDispose<HealthSyncResult>((ref) async {
  final repo = ref.watch(healthSyncRepositoryProvider);
  return repo.syncAndPersist('local-user');
});
