import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/database/database.dart';
import '../../data/database/exercise_dao.dart';
import '../../data/sync/flywheel_client.dart';
import '../../data/sync/mock_flywheel_client.dart';
import '../../data/sync/supabase_flywheel_client.dart';
import '../../domain/enums/ontology_enums.dart';
import '../../domain/models/ontology_models.dart';
import '../../presentation/providers/substitution_providers.dart';
import '../../../core/providers/core_providers.dart';

// ═══════════════════════════════════════════════════════
// PROVIDERS
// ═══════════════════════════════════════════════════════

final flywheelClientProvider = Provider<FlywheelClient>((ref) {
  final useSupabase =
      dotenv.get('USE_SUPABASE_FLYWHEEL', fallback: 'false') == 'true';

  if (useSupabase) {
    return SupabaseFlywheelClient(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    );
  }

  final client = MockFlywheelClient();
  ref.onDispose(client.dispose);
  return client;
});

final flywheelSyncServiceProvider = Provider((ref) => FlywheelSyncService(ref));

// ═══════════════════════════════════════════════════════
// SERVICE
// ═══════════════════════════════════════════════════════

class FlywheelSyncService {
  final Ref _ref;

  bool _isSyncing = false;
  Timer? _syncTimer;

  FlywheelSyncService(this._ref);

  // ═══════════════════════════════════════════════════════
  // LIFECYCLE
  // ═══════════════════════════════════════════════════════

  void initialize() {
    _startSyncLoop();
    _startPromotionListener();
    _ensureVectorsInitialized();

    debugPrint('🚀 FlywheelSync: Initialized');
  }

  void dispose() {
    _syncTimer?.cancel();
    _ref.read(flywheelClientProvider).dispose();
  }

  void _startSyncLoop() {
    _syncTimer = Timer.periodic(
      const Duration(seconds: 60),
      (_) => syncPendingTasks(),
    );
  }

  void _startPromotionListener() {
    final client = _ref.read(flywheelClientProvider);

    client.listenToPromotions((event) async {
      debugPrint('📡 Promotion received: ${event['exercise_name']}');
    });
  }

  // ═══════════════════════════════════════════════════════
  // OUTBOUND SYNC
  // ═══════════════════════════════════════════════════════

  Future<void> syncPendingTasks() async {
    if (_isSyncing) return;

    _isSyncing = true;

    try {
      final dao = _ref.read(exerciseDaoProvider);
      final tasks = await dao.getPendingSyncTasks();

      if (tasks.isEmpty) return;

      debugPrint('🚀 Syncing ${tasks.length} tasks...');

      for (final task in tasks) {
        await _processTask(dao, task);
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _processTask(ExerciseDao dao, SyncQueueData task) async {
    try {
      await dao.updateSyncStatus(task.id, SyncStatus.processing);

      final rawPayload = jsonDecode(task.payload) as Map<String, dynamic>;

      final payload = _sanitizePayload(rawPayload);
      final client = _ref.read(flywheelClientProvider);

      switch (task.action) {
        case SyncAction.reportFlywheel:
          await client.reportRejection(
            sourceExerciseId: payload['source_exercise_id'],
            rejectedExerciseId: payload['rejected_exercise_id'],
          );
          break;

        case SyncAction.inferMetadata:
          await client.submitExerciseVariant(sanitizedPayload: payload);
          break;

        case SyncAction.syncOntology:
          final promotions = await client.pullTier1Promotions(
            since: DateTime.now().subtract(const Duration(hours: 24)),
          );
          await _handlePromotions(dao, promotions);
          break;
      }

      await dao.updateSyncStatus(
        task.id,
        SyncStatus.done,
        processedAt: DateTime.now(),
      );
    } catch (e) {
      debugPrint('❌ Sync error: $e');

      await dao.updateSyncStatus(
        task.id,
        SyncStatus.failed,
        error: e.toString(),
      );
    }
  }

  // ═══════════════════════════════════════════════════════
  // INBOUND SYNC & MERGING
  // ═══════════════════════════════════════════════════════

  Future<void> _handlePromotions(
    ExerciseDao dao,
    List<Map<String, dynamic>> promotions,
  ) async {
    if (promotions.isEmpty) return;

    final localExercises = await dao.getAllExercises(tier: ExerciseTier.aiInferred.index);
    
    for (final promo in promotions) {
      final canonicalHash = promo['canonical_hash'] as String?;
      if (canonicalHash == null) continue;

      // Find local Tier 2 tracking entries matching this promoted canonical hash
      final localMatches = localExercises.where((e) => e.canonicalHash == canonicalHash);
      
      for (final local in localMatches) {
        // Construct the global definition from the payload
        final globalName = promo['name'] as String? ?? local.name;
        
        // Mock global definition using existing metadata but promoted tier
        final globalDef = Exercise(
          id: promo['id'] as String? ?? const Uuid().v4(),
          name: globalName,
          primaryMuscleId: local.primaryMuscleId,
          equipment: local.equipment,
          muscles: local.muscles,
          aliases: [],
          movementPattern: local.movementPattern,
          planeOfMotion: local.planeOfMotion,
          angle: local.angle,
          laterality: local.laterality,
          loadingType: local.loadingType,
          cnsCost: local.cnsCost,
          skillLevel: local.skillLevel,
          mechanics: local.mechanics,
          tier: ExerciseTier.curated,
          confidence: 1.0,
          canonicalHash: canonicalHash,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );

        await handleLibraryMerge(
          localExerciseId: local.id,
          globalTier1Definition: globalDef,
          oldLocalName: local.name,
        );
      }
    }
  }

  // ═══════════════════════════════════════════════════════
  // VECTOR INIT (FIXED)
  // ═══════════════════════════════════════════════════════

  Future<void> _ensureVectorsInitialized() async {
    try {
      final vectorRepo = _ref.read(vectorRepositoryProvider);

      final db = _ref.read(appDatabaseProvider);
      final count = await db
          .customSelect("SELECT COUNT(*) as c FROM exercise_vectors")
          .getSingle();

      final c = count.read<int>('c');

      if (c == 0) {
        debugPrint('🧬 Empty vectors → rebuilding...');
        await vectorRepo.rebuildAll();
        // rebuildAll already calls quantize + preload internally
      } else {
        // Quantize + preload for existing data (guarded inside repo)
        await vectorRepo.quantize();
        await vectorRepo.preload();
      }

      debugPrint('🧬 Vector system ready');
    } catch (e) {
      debugPrint('⚠️ Vector init failed: $e');
    }
  }

  // ═══════════════════════════════════════════════════════
  // LIBRARY MERGE
  // ═══════════════════════════════════════════════════════

  Future<void> handleLibraryMerge({
    required String localExerciseId,
    required Exercise globalTier1Definition,
    required String oldLocalName,
  }) async {
    final dao = _ref.read(exerciseDaoProvider);

    await dao.updateExercise(
      localExerciseId,
      ExercisesCompanion(
        name: drift.Value(globalTier1Definition.name),
        tier: const drift.Value(ExerciseTier.curated),
        confidence: const drift.Value(1.0),
        canonicalHash: drift.Value(globalTier1Definition.canonicalHash),
        updatedAt: drift.Value(DateTime.now().toUtc().toIso8601String()),
      ),
    );

    await dao.insertAlias(
      ExerciseAliasesCompanion.insert(
        id: const Uuid().v4(),
        exerciseId: localExerciseId,
        aliasName: oldLocalName,
        isPrimary: const drift.Value(false),
      ),
    );

    debugPrint(
      '🔄 Merge complete: $oldLocalName → ${globalTier1Definition.name}',
    );
  }

  // ═══════════════════════════════════════════════════════
  // CONSENSUS QUERY
  // ═══════════════════════════════════════════════════════

  Future<GlobalConsensusResult?> getExerciseConsensus(
    String canonicalHash,
  ) async {
    return _ref.read(flywheelClientProvider).getConsensus(canonicalHash);
  }

  // ═══════════════════════════════════════════════════════
  // SANITIZER
  // ═══════════════════════════════════════════════════════

  Map<String, dynamic> _sanitizePayload(Map<String, dynamic> raw) {
    final sanitized = Map<String, dynamic>.from(raw);

    sanitized.remove('user_id');
    sanitized.remove('device_id');
    sanitized.remove('ip_address');

    return sanitized;
  }
}
