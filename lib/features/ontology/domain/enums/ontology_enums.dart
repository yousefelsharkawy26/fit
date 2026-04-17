/// All taxonomy enums for the FitOS Exercise Ontology.
///
/// These represent the 9+1 Immutable Ontological Properties that define
/// what an exercise IS (not how it's performed).
///
/// See: exercise_ontology_design.md §3 — V1 Taxonomy Specification
library;

/// The 6 fundamental human movement patterns.
/// Hard boundary in substitution — Push ≠ Pull.
enum MovementPattern {
  push,
  pull,
  hinge,
  squat,
  carry,
  rotation;

  /// Convert from database TEXT to enum.
  static MovementPattern fromString(String value) =>
      MovementPattern.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid MovementPattern: $value'),
      );
}

/// Simplified force vector — replaces academic biomechanical planes.
/// "Incline Bench" ≠ "Decline Bench" even though both are "Push + Chest".
enum ExerciseAngle {
  incline,
  flat,
  decline,
  vertical;

  static ExerciseAngle fromString(String value) =>
      ExerciseAngle.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid ExerciseAngle: $value'),
      );
}

/// Bilateral vs. Unilateral loading.
/// Bulgarian Split Squats (unilateral) cannot be substituted with
/// Leg Press (bilateral) — the training stimulus is fundamentally different.
enum Laterality {
  bilateral,
  unilateral;

  static Laterality fromString(String value) => Laterality.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid Laterality: $value'),
      );
}

/// Axial (spine-loaded) vs. Peripheral (limb-loaded).
/// Safety-critical: if a user tweaks their back, the AI must instantly
/// swap all Axial movements for Peripheral ones.
enum LoadingType {
  axial,
  peripheral;

  static LoadingType fromString(String value) => LoadingType.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid LoadingType: $value'),
      );
}

/// Central Nervous System fatigue cost.
/// You cannot substitute a Heavy Deadlift (high CNS) with a Lying Leg Curl
/// (low CNS) — the volume/fatigue math of the entire workout would break.
enum CnsCost {
  high,
  medium,
  low;

  static CnsCost fromString(String value) => CnsCost.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid CnsCost: $value'),
      );
}

/// Skill complexity gate — prevents the AI from suggesting Olympic lifts
/// to beginners who just wanted an alternative to a Kettlebell Swing.
enum SkillLevel {
  beginner,
  intermediate,
  advanced;

  static SkillLevel fromString(String value) => SkillLevel.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid SkillLevel: $value'),
      );
}

/// Compound vs. Isolation — condensed from joint tracking.
/// If a user wants to swap a Compound (Bench), the AI must suggest
/// another Compound (DB Bench), not an Isolation (Pec Deck).
enum Mechanics {
  compound,
  isolation;

  static Mechanics fromString(String value) => Mechanics.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid Mechanics: $value'),
      );
}

/// Role of a muscle in an exercise — drives the weight differential
/// in vector encoding (primary = 1.0, secondary = 0.4).
enum MuscleRole {
  primary,
  secondary;

  static MuscleRole fromString(String value) => MuscleRole.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid MuscleRole: $value'),
      );
}

/// Trust tier for exercise data quality.
/// Tier 1 = expert-curated ground truth (confidence 1.0).
/// Tier 2 = AI-inferred from user input (confidence 0.0–1.0).
enum ExerciseTier {
  curated(1),
  aiInferred(2);

  const ExerciseTier(this.value);
  final int value;

  static ExerciseTier fromValue(int value) =>
      ExerciseTier.values.firstWhere(
        (e) => e.value == value,
        orElse: () => throw ArgumentError('Invalid ExerciseTier value: $value'),
      );
}

/// Sync queue action types.
enum SyncAction {
  inferMetadata,
  reportFlywheel,
  syncOntology;

  String toDbString() {
    switch (this) {
      case SyncAction.inferMetadata:
        return 'infer_metadata';
      case SyncAction.reportFlywheel:
        return 'report_flywheel';
      case SyncAction.syncOntology:
        return 'sync_ontology';
    }
  }

  static SyncAction fromDbString(String value) {
    switch (value) {
      case 'infer_metadata':
        return SyncAction.inferMetadata;
      case 'report_flywheel':
        return SyncAction.reportFlywheel;
      case 'sync_ontology':
        return SyncAction.syncOntology;
      default:
        throw ArgumentError('Invalid SyncAction: $value');
    }
  }
}

/// Status of items in the sync queue.
enum SyncStatus {
  pending,
  processing,
  done,
  failed;

  static SyncStatus fromString(String value) => SyncStatus.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid SyncStatus: $value'),
      );
}

/// Status of a muscle for the user (Injury/Soreness tracking).
enum MuscleConstraintStatus {
  injured,
  sore,
  target;

  static MuscleConstraintStatus fromString(String value) =>
      MuscleConstraintStatus.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid MuscleConstraintStatus: $value'),
      );
}

/// The three anatomical planes of motion.
enum PlaneOfMotion {
  sagittal,
  frontal,
  transverse;

  static PlaneOfMotion fromString(String value) => PlaneOfMotion.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid PlaneOfMotion: $value'),
      );
}
