import 'package:drift/drift.dart';
import 'ontology_converters.dart';

/// ──────────────────────────────────────────────────────────────────────
/// FitOS Exercise Ontology — Drift Table Definitions
///
/// Schema matches: exercise_ontology_design.md §4
/// All PKs are TEXT (UUID) for offline-first sync safety.
/// All enums stored as TEXT for self-documenting, debuggable data.
/// ──────────────────────────────────────────────────────────────────────

/// The ~25 muscle regions — the "Goldilocks" taxonomy.
/// Granular enough to distinguish Upper vs Lower Chest,
/// Granular enough to distinguish Upper vs Lower Chest,
/// but coarse enough for 95%+ AI inference accuracy.
@DataClassName('MuscleRegionData')
class MuscleRegions extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().unique()();
  TextColumn get muscleGroup => text()();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Equipment catalog — one of the primary substitution triggers.
/// "Squat rack taken" → filter by equipment.
@DataClassName('EquipmentData')
class Equipment extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().unique()();
  TextColumn get icon => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Core exercise entity — the heart of the ontology.
/// Contains all 9+1 immutable ontological dimensions plus trust metadata.
@DataClassName('ExerciseData')
class Exercises extends Table {
  // Identity
  TextColumn get id => text()();
  TextColumn get name => text()();

  // Taxonomy dimensions (9+1)
  TextColumn get equipmentId => text().references(Equipment, #id)();
  TextColumn get primaryMuscleId => text().named('primary_muscle').references(MuscleRegions, #id)();
  TextColumn get movementPattern => text().map(const MovementPatternConverter())(); // Push|Pull|Hinge|Squat|Carry|Rotation
  TextColumn get planeOfMotion => text().named('plane_of_motion').map(const PlaneOfMotionConverter()).nullable()(); // Sagittal|Frontal|Transverse
  TextColumn get angle => text().map(const ExerciseAngleConverter())();           // Incline|Flat|Decline|Vertical
  TextColumn get laterality => text().map(const LateralityConverter())();      // Bilateral|Unilateral
  TextColumn get loadingType => text().map(const LoadingTypeConverter())();     // Axial|Peripheral
  TextColumn get cnsCost => text().map(const CnsCostConverter())();         // High|Medium|Low
  TextColumn get skillLevel => text().map(const SkillLevelConverter())();      // Beginner|Intermediate|Advanced
  TextColumn get mechanics => text().map(const MechanicsConverter())();       // Compound|Isolation

  // Media guidance
  TextColumn get lottieUrl => text().nullable()();
  TextColumn get instructions => text().nullable()();

  // Trust tier metadata
  IntColumn get tier => integer().map(const ExerciseTierConverter()).withDefault(const Constant(1))();
  RealColumn get confidence => real().withDefault(const Constant(1.0))();
  TextColumn get canonicalHash => text().nullable()();

  // Ownership
  TextColumn get createdBy => text().nullable()();

  // Timestamps (ISO8601)
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Junction table: Exercise ↔ Muscle Region (many-to-many).
/// The `role` column ('primary'|'secondary') drives weight differentiation
/// in the vector encoder: primary=1.0, secondary=0.4.
@DataClassName('ExerciseMuscleData')
@TableIndex(name: 'idx_exercise_muscles_exercise_id', columns: {#exerciseId})
@TableIndex(name: 'idx_exercise_muscles_muscle_id', columns: {#muscleId})
class ExerciseMuscles extends Table {
  TextColumn get exerciseId => text().references(Exercises, #id)();
  TextColumn get muscleId => text().references(MuscleRegions, #id)();
  TextColumn get role => text().map(const MuscleRoleConverter())(); // 'primary' | 'secondary'

  @override
  Set<Column> get primaryKey => {exerciseId, muscleId};
}

/// Exercise aliases / synonyms.
/// "Skull Crusher" = "Lying Tricep Extension" = "French Press"
/// All map to the same exercise UUID → keeps the vector index clean.
@DataClassName('ExerciseAliasData')
class ExerciseAliases extends Table {
  TextColumn get id => text()();
  TextColumn get exerciseId => text().references(Exercises, #id)();
  TextColumn get aliasName => text()();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Per-user substitution feedback — the User-Correction Loop.
/// When a user thumbs-down a suggestion, we store the rejection
/// so the engine never repeats the same bad recommendation.
@DataClassName('SubstitutionFeedbackData')
class SubstitutionFeedback extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  
  @ReferenceName('asSource')
  TextColumn get sourceExerciseId => text().references(Exercises, #id)();
  
  @ReferenceName('asRejection')
  TextColumn get rejectedExerciseId => text().references(Exercises, #id)();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {userId, sourceExerciseId, rejectedExerciseId},
  ];
}

/// Offline sync queue — holds pending operations for when connectivity returns.
/// `infer_metadata` actions are never dropped (cap overflow drops `report_flywheel` first).
class SyncQueue extends Table {
  TextColumn get id => text()();
  TextColumn get action => text().map(const SyncActionConverter())();    // 'infer_metadata' | 'report_flywheel'
  TextColumn get payload => text()();   // JSON
  TextColumn get status => text().map(const SyncStatusConverter()).withDefault(const Constant('pending'))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  TextColumn get createdAt => text()();
  TextColumn get processedAt => text().nullable()();
  TextColumn get updatedAt => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Per-user preferences for specific exercises (Favorites/Dislikes).
@DataClassName('UserPreferenceData')
class UserPreferences extends Table {
  TextColumn get userId => text()();
  TextColumn get exerciseId => text().references(Exercises, #id)();
  RealColumn get preferenceScore => real().withDefault(const Constant(1.0))(); // >1.0 for Favorites, <1.0 for Dislikes
  BoolColumn get isBlacklisted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {userId, exerciseId};
}

/// Active muscle constraints (Injuries/Soreness/Targets).
@DataClassName('UserMuscleConstraintData')
class UserMuscleConstraints extends Table {
  TextColumn get userId => text()();
  TextColumn get muscleId => text().references(MuscleRegions, #id)();
  TextColumn get status => text().map(const MuscleConstraintStatusConverter())();
  TextColumn get expiresAt => text().nullable()(); // ISO8601, NULL means permanent

  @override
  Set<Column> get primaryKey => {userId, muscleId};
}

/// Migration Sentinel for the Anonymous-to-Identity merge.
/// Tracks atomic operations to prevent corrupted states.
class MigrationStatus extends Table {
  TextColumn get id => text()();
  TextColumn get state => text()(); // 'pending', 'completed', 'failed'
  TextColumn get fromUserId => text()();
  TextColumn get toUserId => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Stores the user's Baseline Biometric Profile from Day 0 Onboarding.
@DataClassName('UserBiometricData')
class UserBiometrics extends Table {
  TextColumn get userId => text()();
  TextColumn get experienceLevel => text().nullable()();
  TextColumn get primaryGoal => text().nullable()();
  TextColumn get equipmentAvailability => text().nullable()(); // JSON Array
  RealColumn get weight => real().nullable()();
  RealColumn get height => real().nullable()();
  IntColumn get age => integer().nullable()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {userId};
}
