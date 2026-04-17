import 'package:drift/drift.dart';

class UserStats extends Table {
  TextColumn get userId => text().withLength(min: 1, max: 50).withDefault(const Constant('local-user'))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  IntColumn get streakShields => integer().withDefault(const Constant(2))(); // Start with 2 shields
  DateTimeColumn get lastWorkoutDate => dateTime().nullable()();
  
  // Overall RPG Rank
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {userId};
}

class MuscleExperience extends Table {
  TextColumn get userId => text().withLength(min: 1, max: 50).withDefault(const Constant('local-user'))();
  TextColumn get muscleRegionId => text()(); // Links to Exercise Ontology muscle regions
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {userId, muscleRegionId};
}
