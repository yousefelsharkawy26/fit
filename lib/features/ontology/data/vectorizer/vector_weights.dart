/// Tunable weight constants for the vector encoding dimensions.
///
/// These multipliers bias cosine similarity toward the dimensions
/// that matter most for substitution quality.
///
/// Post-launch tuning: adjust these values, trigger a full re-index
/// via VectorComputeService.rebuildAll(), and push an app update.
///
/// See: exercise_ontology_design.md §5.2 — Weight Hierarchy
class VectorWeights {
  VectorWeights._();

  /// ×3.0 — Muscles are the #1 reason users want a specific exercise.
  /// A substitution that misses the target muscle is useless.
  static const double muscles = 3.0;

  /// Primary muscle activation value (before weight multiplication).
  static const double primaryRole = 1.0;

  /// Secondary muscle activation value (before weight multiplication).
  /// Secondary muscles contribute ~40% of the signal vs. primary.
  static const double secondaryRole = 0.4;

  /// ×2.5 — Push ≠ Pull. Movement pattern mismatch breaks workout logic.
  static const double movementPattern = 2.5;

  /// ×2.0 — Equipment is the most common substitution trigger.
  static const double equipment = 2.0;

  /// ×2.0 — Axial vs. Peripheral is safety-critical (back pain use case).
  static const double loadingType = 2.0;

  /// ×1.5 — Incline ≠ Decline precision, but less catastrophic if off.
  static const double angle = 1.5;

  /// ×1.5 — Bilateral ↔ Unilateral is important but tolerableif off.
  static const double laterality = 1.5;

  /// ×1.0 — Medium CNS sub for High CNS is acceptable in a pinch.
  static const double cnsCost = 1.0;

  /// ×1.0 — Compound ↔ Isolation is noticeable but survivable.
  static const double mechanics = 1.0;

  /// ×0.5 — Soft preference: an Intermediate user CAN do a Beginner exercise.
  static const double skillLevel = 0.5;
}
