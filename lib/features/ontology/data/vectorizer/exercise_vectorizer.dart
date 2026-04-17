import 'dart:typed_data';

import '../../domain/models/ontology_models.dart';
import 'dimension_registry.dart';
import 'vector_weights.dart';

/// Deterministic weighted one-hot encoder for exercises.
///
/// Converts a fully hydrated [Exercise] domain model into an 80-dimension
/// Float32List vector suitable for cosine similarity search in sqlite-vec.
///
/// The encoding is fully deterministic: given the same exercise data,
/// it will always produce the exact same vector. This means:
///   - Tier 1 vectors can be pre-computed at build time
///   - Vectors can be recomputed on any device with identical results
///   - Weight tuning only requires a re-index, not model retraining
///
/// See: exercise_ontology_design.md §5 — Vector Encoding Strategy
class ExerciseVectorizer {
  const ExerciseVectorizer();

  /// Encode an exercise into an 80-dimension weighted vector.
  ///
  /// Returns a [Float32List] ready for insertion into the sqlite-vec
  /// virtual table.
  Float32List encode(Exercise exercise) {
    final vector = Float32List(DimensionRegistry.totalDimensions);

    _encodePrimaryMuscles(vector, exercise);
    _encodeSecondaryMuscles(vector, exercise);
    _encodeEquipment(vector, exercise);
    _encodeMovementPattern(vector, exercise);
    _encodeAngle(vector, exercise);
    _encodeLaterality(vector, exercise);
    _encodeLoadingType(vector, exercise);
    _encodeCnsCost(vector, exercise);
    _encodeSkillLevel(vector, exercise);
    _encodeMechanics(vector, exercise);

    return vector;
  }

  // ─────────── Primary Muscles (dims 0–24, weight ×3.0) ───────────

  void _encodePrimaryMuscles(Float32List vector, Exercise exercise) {
    final offset = DimensionRegistry.primaryMuscleOffset;
    for (final em in exercise.primaryMuscles) {
      final idx = DimensionRegistry.muscleIndex[em.muscle.id];
      if (idx != null) {
        vector[offset + idx] =
            VectorWeights.primaryRole * VectorWeights.muscles;
      }
    }
  }

  // ─────────── Secondary Muscles (dims 25–49, weight ×3.0 × 0.4) ─

  void _encodeSecondaryMuscles(Float32List vector, Exercise exercise) {
    final offset = DimensionRegistry.secondaryMuscleOffset;
    for (final em in exercise.secondaryMuscles) {
      final idx = DimensionRegistry.muscleIndex[em.muscle.id];
      if (idx != null) {
        vector[offset + idx] =
            VectorWeights.secondaryRole * VectorWeights.muscles;
      }
    }
  }

  // ─────────── Equipment (dims 50–57, weight ×2.0) ────────────────

  void _encodeEquipment(Float32List vector, Exercise exercise) {
    final offset = DimensionRegistry.equipmentOffset;
    final idx = DimensionRegistry.equipmentIndex[exercise.equipment.id];
    if (idx != null) {
      vector[offset + idx] = VectorWeights.equipment;
    }
  }

  // ─────────── Movement Pattern (dims 58–63, weight ×2.5) ─────────

  void _encodeMovementPattern(Float32List vector, Exercise exercise) {
    final offset = DimensionRegistry.patternOffset;
    final idx = DimensionRegistry.movementPatternIndex(exercise.movementPattern);
    vector[offset + idx] = VectorWeights.movementPattern;
  }

  // ─────────── Angle (dims 64–67, weight ×1.5) ────────────────────

  void _encodeAngle(Float32List vector, Exercise exercise) {
    final offset = DimensionRegistry.angleOffset;
    final idx = DimensionRegistry.angleIndex(exercise.angle);
    vector[offset + idx] = VectorWeights.angle;
  }

  // ─────────── Laterality (dims 68–69, weight ×1.5) ───────────────

  void _encodeLaterality(Float32List vector, Exercise exercise) {
    final offset = DimensionRegistry.lateralityOffset;
    final idx = DimensionRegistry.lateralityIndex(exercise.laterality);
    vector[offset + idx] = VectorWeights.laterality;
  }

  // ─────────── Loading Type (dims 70–71, weight ×2.0) ─────────────

  void _encodeLoadingType(Float32List vector, Exercise exercise) {
    final offset = DimensionRegistry.loadingOffset;
    final idx = DimensionRegistry.loadingTypeIndex(exercise.loadingType);
    vector[offset + idx] = VectorWeights.loadingType;
  }

  // ─────────── CNS / Fatigue Cost (dims 72–74, weight ×1.0) ──────

  void _encodeCnsCost(Float32List vector, Exercise exercise) {
    final offset = DimensionRegistry.cnsOffset;
    final idx = DimensionRegistry.cnsCostIndex(exercise.cnsCost);
    vector[offset + idx] = VectorWeights.cnsCost;
  }

  // ─────────── Skill Level (dims 75–77, weight ×0.5) ──────────────

  void _encodeSkillLevel(Float32List vector, Exercise exercise) {
    final offset = DimensionRegistry.skillOffset;
    final idx = DimensionRegistry.skillLevelIndex(exercise.skillLevel);
    vector[offset + idx] = VectorWeights.skillLevel;
  }

  // ─────────── Mechanics (dims 78–79, weight ×1.0) ────────────────

  void _encodeMechanics(Float32List vector, Exercise exercise) {
    final offset = DimensionRegistry.mechanicsOffset;
    final idx = DimensionRegistry.mechanicsIndex(exercise.mechanics);
    vector[offset + idx] = VectorWeights.mechanics;
  }

  /// Debug utility: print a human-readable breakdown of the vector.
  String debugVector(Float32List vector) {
    final buffer = StringBuffer();
    buffer.writeln('Vector (${vector.length} dims):');

    void printSegment(String label, int offset, int slots) {
      final segment = vector.sublist(offset, offset + slots);
      final nonZero = <int, double>{};
      for (int i = 0; i < segment.length; i++) {
        if (segment[i] != 0) nonZero[i] = segment[i];
      }
      if (nonZero.isNotEmpty) {
        buffer.writeln('  $label: $nonZero');
      }
    }

    printSegment('Primary Muscles', DimensionRegistry.primaryMuscleOffset, DimensionRegistry.muscleSlots);
    printSegment('Secondary Muscles', DimensionRegistry.secondaryMuscleOffset, DimensionRegistry.muscleSlots);
    printSegment('Equipment', DimensionRegistry.equipmentOffset, DimensionRegistry.equipmentSlots);
    printSegment('Pattern', DimensionRegistry.patternOffset, DimensionRegistry.movementPatternSlots);
    printSegment('Angle', DimensionRegistry.angleOffset, DimensionRegistry.angleSlots);
    printSegment('Laterality', DimensionRegistry.lateralityOffset, DimensionRegistry.lateralitySlots);
    printSegment('Loading', DimensionRegistry.loadingOffset, DimensionRegistry.loadingTypeSlots);
    printSegment('CNS', DimensionRegistry.cnsOffset, DimensionRegistry.cnsCostSlots);
    printSegment('Skill', DimensionRegistry.skillOffset, DimensionRegistry.skillLevelSlots);
    printSegment('Mechanics', DimensionRegistry.mechanicsOffset, DimensionRegistry.mechanicsSlots);

    return buffer.toString();
  }
}
