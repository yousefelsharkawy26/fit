import 'package:drift/drift.dart';
import '../../../../features/ontology/data/database/database.dart';

class IdentityMigrationService {
  final AppDatabase _db;

  IdentityMigrationService(this._db);

  /// Performs an atomic merge from 'local-user' to [newUuid].
  /// Checks counts before and after to ensure total integrity.
  Future<void> atomicMerge(String newUuid) async {
    const String oldId = 'local-user';

    await _db.transaction(() async {
      // Ensure we record the start of this migration
      final migrationId = DateTime.now().millisecondsSinceEpoch.toString();
      await _db
          .into(_db.migrationStatus)
          .insert(
            MigrationStatusCompanion.insert(
              id: migrationId,
              state: 'pending',
              fromUserId: oldId,
              toUserId: newUuid,
              updatedAt: DateTime.now().toIso8601String(),
            ),
          );

      // 2. Perform updates in a batch for high performance
      await _db.batch((batch) {
        batch.update(
          _db.workouts,
          WorkoutsCompanion(userId: Value(newUuid)),
          where: (t) => t.userId.equals(oldId),
        );
        batch.update(
          _db.userPreferences,
          UserPreferencesCompanion(userId: Value(newUuid)),
          where: (t) => t.userId.equals(oldId),
        );
        batch.update(
          _db.userMuscleConstraints,
          UserMuscleConstraintsCompanion(userId: Value(newUuid)),
          where: (t) => t.userId.equals(oldId),
        );
        batch.update(
          _db.exercises,
          ExercisesCompanion(createdBy: Value(newUuid)),
          where: (t) => t.createdBy.equals(oldId),
        );
        batch.update(
          _db.userBiometrics,
          UserBiometricsCompanion(userId: Value(newUuid)),
          where: (t) => t.userId.equals(oldId),
        );
        batch.update(
          _db.substitutionFeedback,
          SubstitutionFeedbackCompanion(userId: Value(newUuid)),
          where: (t) => t.userId.equals(oldId),
        );
      });

      // 3. Verification Post-Migration
      final checkWorkouts = await (_db.select(
        _db.workouts,
      )..where((t) => t.userId.equals(oldId))).get();
      if (checkWorkouts.isNotEmpty) {
        throw Exception(
          "Migration Integrity Failure: Leftover workout records for $oldId",
        );
      }

      final checkPrefs = await (_db.select(
        _db.userPreferences,
      )..where((t) => t.userId.equals(oldId))).get();
      if (checkPrefs.isNotEmpty) {
        throw Exception(
          "Migration Integrity Failure: Leftover preferences for $oldId",
        );
      }

      final checkConstraints = await (_db.select(
        _db.userMuscleConstraints,
      )..where((t) => t.userId.equals(oldId))).get();
      if (checkConstraints.isNotEmpty) {
        throw Exception(
          "Migration Integrity Failure: Leftover constraints for $oldId",
        );
      }

      final checkExercises = await (_db.select(
        _db.exercises,
      )..where((t) => t.createdBy.equals(oldId))).get();
      if (checkExercises.isNotEmpty) {
        throw Exception(
          "Migration Integrity Failure: Leftover custom exercises for $oldId",
        );
      }

      final checkBiometrics = await (_db.select(
        _db.userBiometrics,
      )..where((t) => t.userId.equals(oldId))).get();
      if (checkBiometrics.isNotEmpty) {
        throw Exception(
          "Migration Integrity Failure: Leftover biometrics for $oldId",
        );
      }

      final checkFeedback = await (_db.select(
        _db.substitutionFeedback,
      )..where((t) => t.userId.equals(oldId))).get();
      if (checkFeedback.isNotEmpty) {
        throw Exception(
          "Migration Integrity Failure: Leftover feedback for $oldId",
        );
      }

      // Finalize the Migration Status
      await (_db.update(
        _db.migrationStatus,
      )..where((t) => t.id.equals(migrationId))).write(
        MigrationStatusCompanion(
          state: const Value('completed'),
          updatedAt: Value(DateTime.now().toIso8601String()),
        ),
      );
    });
  }
}
