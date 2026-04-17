import 'dart:typed_data';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show debugPrint;

import '../database/database.dart';
import '../vectorizer/dimension_registry.dart';
import '../vectorizer/vector_compute_service.dart';

/// The vector init options string — single source of truth.
final String _vectorInitOptions =
    'dimension=${DimensionRegistry.totalDimensions},type=FLOAT32,distance=COSINE';

class VectorRepository {
  final AppDatabase db;
  final VectorComputeService computeService;

  VectorRepository(this.db, this.computeService);

  // ═══════════════════════
  // INSERT
  // ═══════════════════════
  Future<void> insertVector(String id, Float32List vector) async {
    await db.customInsert(
      '''
      INSERT INTO exercise_vectors (exercise_id, vector)
      VALUES (?, vector_as_f32(?))
      ON CONFLICT(exercise_id)
      DO UPDATE SET vector = excluded.vector
      ''',
      variables: [
        Variable.withString(id),
        Variable.withBlob(vector.buffer.asUint8List()),
      ],
    );
  }

  // ═══════════════════════
  // QUANTIZE (GUARDED)
  // ═══════════════════════
  Future<void> quantize() async {
    final count = await _vectorCount();
    if (count == 0) {
      debugPrint('⏭️ vector_quantize skipped: 0 rows');
      return;
    }
    await db.customStatement(
      "SELECT vector_quantize('exercise_vectors', 'vector')",
    );
    debugPrint('🧬 vector_quantize OK ($count rows)');
  }

  // ═══════════════════════
  // PRELOAD (GUARDED)
  // ═══════════════════════
  Future<void> preload() async {
    final count = await _vectorCount();
    if (count == 0) {
      debugPrint('⏭️ vector_quantize_preload skipped: 0 rows');
      return;
    }
    await db.customStatement(
      "SELECT vector_quantize_preload('exercise_vectors', 'vector')",
    );
    debugPrint('🧬 vector_quantize_preload OK');
  }

  // ═══════════════════════
  // SEARCH (FIXED)
  // ═══════════════════════
  Future<List<MapEntry<String, double>>> findSimilar(
    Float32List target, {
    int limit = 10,
  }) async {
    try {
      final count = await _vectorCount();
      if (count == 0) return [];

      final result = await db
          .customSelect(
            '''
        SELECT ev.exercise_id, v.distance
        FROM vector_quantize_scan('exercise_vectors','vector', ?, ?) v
        JOIN exercise_vectors ev ON ev.id = v.rowid
        ORDER BY v.distance ASC
        LIMIT ?
        ''',
            variables: [
              Variable.withBlob(target.buffer.asUint8List()),
              Variable.withInt(limit),
              Variable.withInt(limit),
            ],
          )
          .get();

      return result.map((r) {
        return MapEntry(
          r.read<String>('exercise_id'),
          r.read<double>('distance'),
        );
      }).toList();
    } catch (e) {
      debugPrint('❌ Vector search failed: $e');
      return [];
    }
  }

  // ═══════════════════════
  // REBUILD (CORRECT PIPELINE)
  // ═══════════════════════
  Future<void> rebuildAll() async {
    await ensureVectorReady();

    final exercises = await db.exerciseDao.getAllExercises();
    if (exercises.isEmpty) {
      debugPrint('⏭️ rebuildAll skipped: no exercises');
      return;
    }

    final vectors = await computeService.computeBatch(exercises);

    await db.transaction(() async {
      await db.customStatement('DELETE FROM exercise_vectors');

      for (final entry in vectors.entries) {
        await insertVector(entry.key, entry.value);
      }
    });

    debugPrint('🧬 Inserted ${vectors.length} vectors');

    // Re-init after bulk insert, then quantize + preload
    await ensureVectorReady();
    await quantize();
    await preload();
  }

  // ═══════════════════════
  // SAFE INIT (NO CRASH)
  // ═══════════════════════
  Future<void> ensureVectorReady() async {
    try {
      await db.customStatement(
        "SELECT vector_init('exercise_vectors', 'vector', '$_vectorInitOptions')",
      );
    } catch (e) {
      // Ignore if already initialized — this is expected
    }
  }

  // ═══════════════════════
  // HELPERS
  // ═══════════════════════
  Future<int> _vectorCount() async {
    final row = await db
        .customSelect("SELECT COUNT(*) as c FROM exercise_vectors")
        .getSingle();
    return row.read<int>('c');
  }
}
