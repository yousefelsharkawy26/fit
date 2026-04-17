import 'package:fit/features/coaching/presentation/providers/coaching_providers.dart';
import 'package:fit/features/health/domain/models/health_snapshot.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../health/presentation/providers/health_providers.dart';
import '../../domain/services/recovery_synthesis_service.dart';
import '../../domain/models/recovery_readiness.dart';

final recoverySynthesisServiceProvider = Provider<RecoverySynthesisService>((
  ref,
) {
  return RecoverySynthesisService();
});

/// Synthesizes health signals and training load into a single Readiness score.
final recoveryReadinessProvider =
    FutureProvider.autoDispose<RecoveryReadiness>((ref) async {
      final dashboard = await ref.watch(coachingDashboardProvider.future);
      
      HealthSnapshot? health;
      try {
        health = await ref.watch(latestHealthSnapshotProvider.future);
      } catch (_) {
        // Fallback to null if health fetch fails or doesn't exist
      }

      final service = ref.watch(recoverySynthesisServiceProvider);
      return service.calculateReadiness(dashboard, health);
    });
