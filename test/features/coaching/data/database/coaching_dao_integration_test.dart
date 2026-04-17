import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:fit/features/coaching/data/database/coaching_tables.dart';
import 'package:fit/features/ontology/data/database/database.dart';
import 'package:fit/features/ontology/domain/enums/ontology_enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoachingDao integration', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
    });

    tearDown(() async {
      await db.close();
    });

    test(
      'getWeeklyMuscleVolume excludes cardio rows in mixed workout sets',
      () async {
        const userId = 'test-user';
        const workoutId = 'workout-1';
        const workoutExerciseId = 'workout-ex-1';
        const muscleId = 'muscle-legs-test';
        const equipmentId = 'equipment-test';
        const exerciseId = 'exercise-test';

        await db
            .into(db.muscleRegions)
            .insert(
              MuscleRegionsCompanion.insert(
                id: muscleId,
                name: 'Test Quads',
                muscleGroup: 'legs',
                displayOrder: Value(1),
              ),
            );
        await db
            .into(db.equipment)
            .insert(
              EquipmentCompanion.insert(id: equipmentId, name: 'Test Barbell'),
            );
        await db
            .into(db.exercises)
            .insert(
              ExercisesCompanion.insert(
                id: exerciseId,
                name: 'Test Squat',
                equipmentId: equipmentId,
                primaryMuscleId: muscleId,
                movementPattern: MovementPattern.squat,
                angle: ExerciseAngle.vertical,
                laterality: Laterality.bilateral,
                loadingType: LoadingType.axial,
                cnsCost: CnsCost.high,
                skillLevel: SkillLevel.intermediate,
                mechanics: Mechanics.compound,
                tier: const Value(ExerciseTier.curated),
                confidence: const Value(1.0),
                canonicalHash: const Value('test-hash'),
                createdAt: DateTime.now().toIso8601String(),
                updatedAt: DateTime.now().toIso8601String(),
              ),
            );
        await db
            .into(db.exerciseMuscles)
            .insert(
              ExerciseMusclesCompanion.insert(
                exerciseId: exerciseId,
                muscleId: muscleId,
                role: MuscleRole.primary,
              ),
            );

        await db
            .into(db.workouts)
            .insert(
              WorkoutsCompanion.insert(
                id: workoutId,
                userId: userId,
                status: WorkoutStatus.completed,
                completedAt: Value(DateTime.now()),
                createdAt: Value(DateTime.now()),
              ),
            );
        await db
            .into(db.workoutExercises)
            .insert(
              WorkoutExercisesCompanion.insert(
                id: workoutExerciseId,
                workoutId: workoutId,
                exerciseId: exerciseId,
                orderIndex: 0,
                createdAt: Value(DateTime.now()),
              ),
            );

        // Strength set should be counted in weekly muscle volume.
        await db
            .into(db.workoutSets)
            .insert(
              WorkoutSetsCompanion.insert(
                id: 'set-strength',
                workoutExerciseId: workoutExerciseId,
                setType: SetType.working,
                trackingType: const Value(TrackingType.strength),
                weight: const Value(100),
                reps: const Value(5),
                createdAt: Value(DateTime.now()),
              ),
            );
        // Cardio set should be excluded from weekly muscle volume.
        await db
            .into(db.workoutSets)
            .insert(
              WorkoutSetsCompanion.insert(
                id: 'set-cardio',
                workoutExerciseId: workoutExerciseId,
                setType: SetType.working,
                trackingType: const Value(TrackingType.cardio),
                weight: const Value(0),
                reps: const Value(0),
                distance: const Value(2000),
                duration: const Value(600),
                createdAt: Value(DateTime.now()),
              ),
            );

        final volume = await db.coachingDao.getWeeklyMuscleVolume(userId);

        expect(volume.length, 1);
        expect(volume.first.muscleName, 'Test Quads');
        expect(
          volume.first.volume,
          500.0,
          reason: 'Only the strength set should contribute: 100kg × 5reps × 1.0 primary.',
        );
      },
    );
  });
}
