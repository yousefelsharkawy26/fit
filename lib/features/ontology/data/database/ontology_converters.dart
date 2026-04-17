import 'package:drift/drift.dart';
import '../../domain/enums/ontology_enums.dart';

/// ──────────────────────────────────────────────────────────────────────
/// FitOS Exercise Ontology — Drift Type Converters
///
/// Converts Dart enums to/from database TEXT types for local storage.
/// This ensures the database remains readable and easily debuggable,
/// rather than storing opaque integers for enums.
/// ──────────────────────────────────────────────────────────────────────

class MovementPatternConverter extends TypeConverter<MovementPattern, String> {
  const MovementPatternConverter();
  @override
  MovementPattern fromSql(String fromDb) => MovementPattern.fromString(fromDb);
  @override
  String toSql(MovementPattern value) => value.name;
}

class ExerciseAngleConverter extends TypeConverter<ExerciseAngle, String> {
  const ExerciseAngleConverter();
  @override
  ExerciseAngle fromSql(String fromDb) => ExerciseAngle.fromString(fromDb);
  @override
  String toSql(ExerciseAngle value) => value.name;
}

class LateralityConverter extends TypeConverter<Laterality, String> {
  const LateralityConverter();
  @override
  Laterality fromSql(String fromDb) => Laterality.fromString(fromDb);
  @override
  String toSql(Laterality value) => value.name;
}

class LoadingTypeConverter extends TypeConverter<LoadingType, String> {
  const LoadingTypeConverter();
  @override
  LoadingType fromSql(String fromDb) => LoadingType.fromString(fromDb);
  @override
  String toSql(LoadingType value) => value.name;
}

class CnsCostConverter extends TypeConverter<CnsCost, String> {
  const CnsCostConverter();
  @override
  CnsCost fromSql(String fromDb) => CnsCost.fromString(fromDb);
  @override
  String toSql(CnsCost value) => value.name;
}

class SkillLevelConverter extends TypeConverter<SkillLevel, String> {
  const SkillLevelConverter();
  @override
  SkillLevel fromSql(String fromDb) => SkillLevel.fromString(fromDb);
  @override
  String toSql(SkillLevel value) => value.name;
}

class MechanicsConverter extends TypeConverter<Mechanics, String> {
  const MechanicsConverter();
  @override
  Mechanics fromSql(String fromDb) => Mechanics.fromString(fromDb);
  @override
  String toSql(Mechanics value) => value.name;
}

class MuscleRoleConverter extends TypeConverter<MuscleRole, String> {
  const MuscleRoleConverter();
  @override
  MuscleRole fromSql(String fromDb) => MuscleRole.fromString(fromDb);
  @override
  String toSql(MuscleRole value) => value.name;
}

class ExerciseTierConverter extends TypeConverter<ExerciseTier, int> {
  const ExerciseTierConverter();
  @override
  ExerciseTier fromSql(int fromDb) => ExerciseTier.fromValue(fromDb);
  @override
  int toSql(ExerciseTier value) => value.value;
}

class SyncActionConverter extends TypeConverter<SyncAction, String> {
  const SyncActionConverter();
  @override
  SyncAction fromSql(String fromDb) => SyncAction.fromDbString(fromDb);
  @override
  String toSql(SyncAction value) => value.toDbString();
}

class SyncStatusConverter extends TypeConverter<SyncStatus, String> {
  const SyncStatusConverter();
  @override
  SyncStatus fromSql(String fromDb) => SyncStatus.fromString(fromDb);
  @override
  String toSql(SyncStatus value) => value.name;
}

class MuscleConstraintStatusConverter extends TypeConverter<MuscleConstraintStatus, String> {
  const MuscleConstraintStatusConverter();
  @override
  MuscleConstraintStatus fromSql(String fromDb) => MuscleConstraintStatus.fromString(fromDb);
  @override
  String toSql(MuscleConstraintStatus value) => value.name;
}

class PlaneOfMotionConverter extends TypeConverter<PlaneOfMotion, String> {
  const PlaneOfMotionConverter();
  @override
  PlaneOfMotion fromSql(String fromDb) => PlaneOfMotion.fromString(fromDb);
  @override
  String toSql(PlaneOfMotion value) => value.name;
}
