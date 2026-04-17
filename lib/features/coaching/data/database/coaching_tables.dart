import 'package:drift/drift.dart';
import '../../../ontology/data/database/ontology_tables.dart';

@DataClassName('Workout')
@TableIndex(name: 'idx_workouts_user_history', columns: {#userId, #status, #completedAt})
@TableIndex(name: 'idx_workouts_user_id', columns: {#userId})
class Workouts extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text().nullable()();
  TextColumn get status => text().map(const WorkoutStatusConverter())();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  RealColumn get volumeLoad => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutExercise')
@TableIndex(name: 'idx_workout_exercises_workout_id', columns: {#workoutId})
@TableIndex(name: 'idx_workout_exercises_exercise_id', columns: {#exerciseId})
class WorkoutExercises extends Table {
  TextColumn get id => text()();
  TextColumn get workoutId =>
      text().references(Workouts, #id, onDelete: KeyAction.cascade)();
  TextColumn get exerciseId => text().references(Exercises, #id)();
  IntColumn get orderIndex => integer()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutSet')
@TableIndex(name: 'idx_workout_sets_workout_exercise_id', columns: {#workoutExerciseId})
class WorkoutSets extends Table {
  TextColumn get id => text()();
  TextColumn get workoutExerciseId =>
      text().references(WorkoutExercises, #id, onDelete: KeyAction.cascade)();
  TextColumn get setType => text().map(const SetTypeConverter())();
  TextColumn get trackingType =>
      text().map(const TrackingTypeConverter()).withDefault(
        const Constant('strength'),
      )();
  RealColumn get weight => real().nullable()();
  IntColumn get reps => integer().nullable()();
  RealColumn get rpe => real().nullable()();
  RealColumn get distance => real().nullable()();
  IntColumn get duration => integer().nullable()();
  IntColumn get heartRate => integer().nullable()();
  BoolColumn get isPr => boolean().withDefault(const Constant(false))();
  IntColumn get restSeconds => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

enum WorkoutStatus { planned, active, completed, cancelled }

enum SetType { warmup, working, top, backoff, amrap }

enum TrackingType { strength, cardio }

extension TrackingTypeX on TrackingType {
  bool get isStrength => this == TrackingType.strength;
  bool get isCardio => this == TrackingType.cardio;

  /// Returns the column that represents the primary volume metric for this type.
  String get volumeLabel => isStrength ? 'Weight' : 'Distance';
  String get volumeUnit => isStrength ? 'kg' : 'm';
}

class WorkoutStatusConverter extends TypeConverter<WorkoutStatus, String> {
  const WorkoutStatusConverter();
  @override
  WorkoutStatus fromSql(String fromDb) => WorkoutStatus.values.byName(fromDb);
  @override
  String toSql(WorkoutStatus value) => value.name;
}

class SetTypeConverter extends TypeConverter<SetType, String> {
  const SetTypeConverter();
  @override
  SetType fromSql(String fromDb) => SetType.values.byName(fromDb);
  @override
  String toSql(SetType value) => value.name;
}

class TrackingTypeConverter extends TypeConverter<TrackingType, String> {
  const TrackingTypeConverter();
  @override
  TrackingType fromSql(String fromDb) => TrackingType.values.byName(fromDb);
  @override
  String toSql(TrackingType value) => value.name;
}
