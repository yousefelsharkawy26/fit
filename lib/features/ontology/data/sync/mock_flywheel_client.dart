import 'dart:math';

import 'flywheel_client.dart';

/// Mock implementation of [FlywheelClient] for offline-first development.
///
/// Simulates the global consensus pool with in-memory state.
/// All submissions are tracked locally and consensus is computed
/// deterministically, allowing full end-to-end testing without a backend.
class MockFlywheelClient implements FlywheelClient {
  /// In-memory consensus pool: canonicalHash → submission count
  final Map<String, int> _consensusPool = {};

  /// In-memory rejection log: sourceId → {rejectedIds}
  final Map<String, Set<String>> _rejections = {};

  /// Simulated network latency range (ms)
  final int _minLatencyMs;
  final int _maxLatencyMs;
  final Random _random = Random();

  /// Promotion listener callback
  void Function(Map<String, dynamic>)? _promotionListener;

  MockFlywheelClient({
    int minLatencyMs = 200,
    int maxLatencyMs = 800,
  })  : _minLatencyMs = minLatencyMs,
        _maxLatencyMs = maxLatencyMs;

  Future<void> _simulateLatency() async {
    final delay = _minLatencyMs + _random.nextInt(_maxLatencyMs - _minLatencyMs);
    await Future.delayed(Duration(milliseconds: delay));
  }

  @override
  Future<GlobalConsensusResult> submitExerciseVariant({
    required Map<String, dynamic> sanitizedPayload,
  }) async {
    await _simulateLatency();

    final hash = sanitizedPayload['canonical_hash'] as String?;
    if (hash == null) {
      return GlobalConsensusResult.fromCount(0);
    }

    // Increment submission count
    _consensusPool[hash] = (_consensusPool[hash] ?? 0) + 1;
    final count = _consensusPool[hash]!;
    final result = GlobalConsensusResult.fromCount(count, hash: hash);

    // If this submission triggers a promotion, fire the listener
    if (result.isPromotedToTier1 && count == GlobalConsensusResult.promotionThreshold) {
      _promotionListener?.call({
        'canonical_hash': hash,
        'exercise_name': sanitizedPayload['exercise_name'],
        'submission_count': count,
        'promoted_at': DateTime.now().toUtc().toIso8601String(),
        'metadata': sanitizedPayload['metadata'],
      });
    }

    return result;
  }

  @override
  Future<void> reportRejection({
    required String sourceExerciseId,
    required String rejectedExerciseId,
  }) async {
    await _simulateLatency();

    _rejections
        .putIfAbsent(sourceExerciseId, () => {})
        .add(rejectedExerciseId);
  }

  @override
  Future<GlobalConsensusResult?> getConsensus(String canonicalHash) async {
    await _simulateLatency();

    final count = _consensusPool[canonicalHash];
    if (count == null) return null;

    return GlobalConsensusResult.fromCount(count, hash: canonicalHash);
  }

  @override
  Future<List<Map<String, dynamic>>> pullTier1Promotions({
    required DateTime since,
  }) async {
    await _simulateLatency();

    // Return all exercises that have reached the promotion threshold
    final promotions = <Map<String, dynamic>>[];
    for (final entry in _consensusPool.entries) {
      if (entry.value >= GlobalConsensusResult.promotionThreshold) {
        promotions.add({
          'canonical_hash': entry.key,
          'submission_count': entry.value,
          'promoted_at': DateTime.now().toUtc().toIso8601String(),
        });
      }
    }
    return promotions;
  }

  @override
  void listenToPromotions(
    void Function(Map<String, dynamic> promotionEvent) onPromotion,
  ) {
    _promotionListener = onPromotion;
  }

  @override
  void dispose() {
    _promotionListener = null;
  }

  // ═══════════════════════════════════════════════════════
  //  TEST HELPERS
  // ═══════════════════════════════════════════════════════

  /// Seed the consensus pool with predetermined counts (for testing).
  void seedConsensus(Map<String, int> seeds) {
    _consensusPool.addAll(seeds);
  }

  /// Get the current rejection log (for assertions).
  Map<String, Set<String>> get rejections => Map.unmodifiable(_rejections);

  /// Get the current consensus pool (for assertions).
  Map<String, int> get consensusPool => Map.unmodifiable(_consensusPool);
}
