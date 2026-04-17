import '../enums/ontology_enums.dart';

/// Domain model for a muscle region in the ontology.
class MuscleRegion {
  final String id;
  final String name;
  final String muscleGroup;
  final int displayOrder;

  const MuscleRegion({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.displayOrder,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MuscleRegion && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'MuscleRegion($name)';
}

/// Domain model for equipment.
class EquipmentModel {
  final String id;
  final String name;
  final String? icon;

  const EquipmentModel({
    required this.id,
    required this.name,
    this.icon,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipmentModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Equipment($name)';
}

/// A muscle's role in an exercise (primary or secondary)
/// plus the muscle region details.
class ExerciseMuscle {
  final MuscleRegion muscle;
  final MuscleRole role;

  const ExerciseMuscle({
    required this.muscle,
    required this.role,
  });

  @override
  String toString() => 'ExerciseMuscle(${muscle.name}, ${role.name})';
}

/// Domain model for an exercise alias (synonym).
class ExerciseAlias {
  final String id;
  final String exerciseId;
  final String aliasName;
  final bool isPrimary;

  const ExerciseAlias({
    required this.id,
    required this.exerciseId,
    required this.aliasName,
    required this.isPrimary,
  });
}

/// Complete domain model for an exercise with all resolved relationships.
class Exercise {
  final String id;
  final String name;
  final String primaryMuscleId;

  // Resolved relationships
  final EquipmentModel equipment;
  final List<ExerciseMuscle> muscles;
  final List<ExerciseAlias> aliases;

  // Taxonomy dimensions
  final MovementPattern movementPattern;
  final PlaneOfMotion? planeOfMotion;
  final ExerciseAngle angle;
  final Laterality laterality;
  final LoadingType loadingType;
  final CnsCost cnsCost;
  final SkillLevel skillLevel;
  final Mechanics mechanics;

  // Media guidance
  final String? lottieUrl;
  final String? instructions;

  // Trust metadata
  final ExerciseTier tier;
  final double confidence;
  final String? canonicalHash;
  final String? createdBy;

  // Timestamps
  final String createdAt;
  final String updatedAt;

  const Exercise({
    required this.id,
    required this.name,
    required this.primaryMuscleId,
    required this.equipment,
    required this.muscles,
    required this.aliases,
    required this.movementPattern,
    this.planeOfMotion,
    required this.angle,
    required this.laterality,
    required this.loadingType,
    required this.cnsCost,
    required this.skillLevel,
    required this.mechanics,
    this.lottieUrl,
    this.instructions,
    required this.tier,
    required this.confidence,
    this.canonicalHash,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Get only primary muscles.
  List<ExerciseMuscle> get primaryMuscles =>
      muscles.where((m) => m.role == MuscleRole.primary).toList();

  /// Get only secondary muscles.
  List<ExerciseMuscle> get secondaryMuscles =>
      muscles.where((m) => m.role == MuscleRole.secondary).toList();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Exercise && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Exercise($name, tier=${tier.name}, conf=$confidence)';
}

/// A substitution result returned by the substitution engine.
class SubstitutionResult {
  final Exercise exercise;
  final double score;
  final bool constraintsRelaxed;
  final List<String> relaxedConstraints;
  final String? personalizationNote;

  const SubstitutionResult({
    required this.exercise,
    required this.score,
    this.constraintsRelaxed = false,
    this.relaxedConstraints = const [],
    this.personalizationNote,
  });

  double get similarityPercent => ((1.0 - score) * 100).clamp(0, 100);

  @override
  String toString() =>
      'SubstitutionResult(${exercise.name}, score=$score, '
      'similarity=${similarityPercent.toStringAsFixed(1)}%)';
}

/// Constraints for the substitution pre-filter (Stage 1).
class SubstitutionConstraints {
  final List<String>? excludeEquipmentIds;
  final Laterality? requireLaterality;
  final LoadingType? excludeLoadingType;
  final SkillLevel? maxSkillLevel;
  final List<String>? excludeExerciseIds;
  final List<String>? injuredMuscleIds;

  const SubstitutionConstraints({
    this.excludeEquipmentIds,
    this.requireLaterality,
    this.excludeLoadingType,
    this.maxSkillLevel,
    this.excludeExerciseIds,
    this.injuredMuscleIds,
  });

  static const empty = SubstitutionConstraints();

  bool get hasConstraints =>
      (excludeEquipmentIds?.isNotEmpty ?? false) ||
      requireLaterality != null ||
      excludeLoadingType != null ||
      maxSkillLevel != null ||
      (excludeExerciseIds?.isNotEmpty ?? false) ||
      (injuredMuscleIds?.isNotEmpty ?? false);

  SubstitutionConstraints copyWith({
    List<String>? excludeEquipmentIds,
    Laterality? requireLaterality,
    LoadingType? excludeLoadingType,
    SkillLevel? maxSkillLevel,
    List<String>? excludeExerciseIds,
    List<String>? injuredMuscleIds,
  }) {
    return SubstitutionConstraints(
      excludeEquipmentIds: excludeEquipmentIds ?? this.excludeEquipmentIds,
      requireLaterality: requireLaterality ?? this.requireLaterality,
      excludeLoadingType: excludeLoadingType ?? this.excludeLoadingType,
      maxSkillLevel: maxSkillLevel ?? this.maxSkillLevel,
      excludeExerciseIds: excludeExerciseIds ?? this.excludeExerciseIds,
      injuredMuscleIds: injuredMuscleIds ?? this.injuredMuscleIds,
    );
  }
}

/// Domain model for per-user muscle constraint (Injury/Soreness).
class MuscleConstraint {
  final String muscleId;
  final MuscleConstraintStatus status;
  final DateTime? expiresAt;

  const MuscleConstraint({
    required this.muscleId,
    required this.status,
    this.expiresAt,
  });

  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);
  bool get isInjured => status == MuscleConstraintStatus.injured;
}

/// Domain model for per-user exercise preference (Favorite/Dislike).
class ExercisePreference {
  final String exerciseId;
  final double preferenceScore;
  final bool isBlacklisted;

  const ExercisePreference({
    required this.exerciseId,
    required this.preferenceScore,
    this.isBlacklisted = false,
  });

  bool get isDisliked => preferenceScore < 1.0;
  bool get isFavorite => preferenceScore > 1.0;
}

/// Represents a biomechanical warning triggered during an active workout.
class InjuryWarning {
  final String exerciseId;
  final String exerciseName;
  final String muscleName;

  const InjuryWarning({
    required this.exerciseId,
    required this.exerciseName,
    required this.muscleName,
  });
}

