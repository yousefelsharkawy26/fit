import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/core_providers.dart';
import '../../domain/models/overload_prescription.dart';
import '../../domain/services/predictive_overload_engine.dart';
import 'recovery_readiness_provider.dart';

/// Exposes the core mathematical engine for prescription calculation.
final predictiveOverloadEngineProvider = Provider<PredictiveOverloadEngine>((ref) {
  return PredictiveOverloadEngine();
});

/// Dynamically yields a predictive overload prescription for a given exercise ID.
/// Automatically re-evaluates if the user's `RecoveryReadiness` changes.
final exercisePrescriptionProvider = FutureProvider.autoDispose.family<OverloadPrescription, String>((ref, exerciseId) async {
  final engine = ref.watch(predictiveOverloadEngineProvider);
  final database = ref.watch(appDatabaseProvider);
  final dao = database.coachingDao;

  // 1. Fetch current systemic recovery state
  final readiness = await ref.watch(recoveryReadinessProvider.future);

  // 2. Query historical true mechanical ceiling (Max 1RM of the last 30 days)
  final historical1RM = await dao.getEstimated1RM('local-user', exerciseId, daysBack: 30);

  // 3. Fallback tracking: Find the standard rep-band for their backoff sets, or default to 8.
  int targetReps = 8;
  final lastSet = await dao.getLastSetVolume('local-user', exerciseId);
  if (lastSet != null && lastSet.reps != null && lastSet.reps! > 0) {
    targetReps = lastSet.reps!;
  }

  // 4. Sythesize mathematics
  return engine.calculatePrescription(
    readiness: readiness,
    historical1RM: historical1RM,
    targetReps: targetReps,
  );
});
