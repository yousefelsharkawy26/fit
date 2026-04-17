
import '../../domain/enums/ontology_enums.dart';
import '../../data/seed/muscle_regions_seed.dart';

/// Maps each enum value and muscle region to a fixed positional index
/// within the 80-dimension one-hot vector.
///
/// CRITICAL: These indices MUST remain stable across app versions.
/// Changing an index invalidates all stored vectors and requires
/// a full re-index.
///
/// See: exercise_ontology_design.md §5 — Vector Encoding Strategy
class DimensionRegistry {
  DimensionRegistry._();

  // ═══════════════════════════════════════════════════════
  //  Muscle Region Indices (0–24) — used for both primary & secondary sub-vectors
  // ═══════════════════════════════════════════════════════

  /// Maps muscle region ID → positional index (0–24).
  /// Derived from the seed data's display_order to ensure consistency.
  static final Map<String, int> muscleIndex = {
    for (int i = 0; i < MuscleRegionSeed.data.length; i++)
      MuscleRegionSeed.data[i]['id'] as String: i,
  };

  /// Total number of muscle region slots.
  static const int muscleSlots = 25;

  // ═══════════════════════════════════════════════════════
  //  Equipment Indices
  // ═══════════════════════════════════════════════════════

  static const Map<String, int> equipmentIndex = {
    'eq-001-barbell': 0,
    'eq-002-dumbbell': 1,
    'eq-003-cable': 2,
    'eq-004-machine': 3,
    'eq-005-bodyweight': 4,
    'eq-006-kettlebell': 5,
    'eq-007-band': 6,
    'eq-008-other': 7,
  };

  static const int equipmentSlots = 8;

  // ═══════════════════════════════════════════════════════
  //  Enum Indices (deterministic from enum value order)
  // ═══════════════════════════════════════════════════════

  static int movementPatternIndex(MovementPattern mp) => mp.index;
  static const int movementPatternSlots = 6; // Push, Pull, Hinge, Squat, Carry, Rotation

  static int angleIndex(ExerciseAngle a) => a.index;
  static const int angleSlots = 4; // Incline, Flat, Decline, Vertical

  static int lateralityIndex(Laterality l) => l.index;
  static const int lateralitySlots = 2; // Bilateral, Unilateral

  static int loadingTypeIndex(LoadingType lt) => lt.index;
  static const int loadingTypeSlots = 2; // Axial, Peripheral

  static int cnsCostIndex(CnsCost c) => c.index;
  static const int cnsCostSlots = 3; // High, Medium, Low

  static int skillLevelIndex(SkillLevel s) => s.index;
  static const int skillLevelSlots = 3; // Beginner, Intermediate, Advanced

  static int mechanicsIndex(Mechanics m) => m.index;
  static const int mechanicsSlots = 2; // Compound, Isolation

  // ═══════════════════════════════════════════════════════
  //  Total Vector Dimension
  // ═══════════════════════════════════════════════════════

  /// Total dimensionality of the exercise vector.
  /// 25 (primary muscles) + 25 (secondary muscles) + 8 (equipment) +
  /// 6 (pattern) + 4 (angle) + 2 (laterality) + 2 (loading) +
  /// 3 (CNS) + 3 (skill) + 2 (mechanics) = 80
  static const int totalDimensions =
      muscleSlots +       // primary muscles: 25
      muscleSlots +       // secondary muscles: 25
      equipmentSlots +    // equipment: 8
      movementPatternSlots + // pattern: 6
      angleSlots +        // angle: 4
      lateralitySlots +   // laterality: 2
      loadingTypeSlots +  // loading: 2
      cnsCostSlots +      // CNS: 3
      skillLevelSlots +   // skill: 3
      mechanicsSlots;     // mechanics: 2

  // ═══════════════════════════════════════════════════════
  //  Sub-vector Offsets
  // ═══════════════════════════════════════════════════════

  static const int primaryMuscleOffset = 0;
  static const int secondaryMuscleOffset = muscleSlots; // 25
  static const int equipmentOffset = secondaryMuscleOffset + muscleSlots; // 50
  static const int patternOffset = equipmentOffset + equipmentSlots; // 58
  static const int angleOffset = patternOffset + movementPatternSlots; // 64
  static const int lateralityOffset = angleOffset + angleSlots; // 68
  static const int loadingOffset = lateralityOffset + lateralitySlots; // 70
  static const int cnsOffset = loadingOffset + loadingTypeSlots; // 72
  static const int skillOffset = cnsOffset + cnsCostSlots; // 75
  static const int mechanicsOffset = skillOffset + skillLevelSlots; // 78
  // Total: 78 + 2 = 80 ✓
}
