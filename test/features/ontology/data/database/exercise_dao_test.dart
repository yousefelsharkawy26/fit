import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' as drift;
import 'package:fit/features/ontology/data/database/database.dart';
import 'package:fit/features/ontology/domain/enums/ontology_enums.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('ExerciseDao Tests', () {
    test(
      'getExerciseById correctly hydrates lottieUrl and instructions',
      () async {
        // 1. Insert required ontology data to satisfy FF constraints (if enabled)
        await db
            .into(db.muscleRegions)
            .insert(
              const MuscleRegionsCompanion(
                id: drift.Value('pecs'),
                name: drift.Value('Pectorals'),
                muscleGroup: drift.Value('Chest'),
              ),
            );

        await db
            .into(db.equipment)
            .insert(
              const EquipmentCompanion(
                id: drift.Value('barbell'),
                name: drift.Value('Barbell'),
              ),
            );

        // 2. Insert exercise
        await db
            .into(db.exercises)
            .insert(
              ExercisesCompanion.insert(
                id: 'test_lottie_exercise',
                name: 'Lottie Exercise',
                primaryMuscleId: 'pecs',
                equipmentId: 'barbell',
                movementPattern: MovementPattern.push,
                angle: ExerciseAngle.flat,
                laterality: Laterality.bilateral,
                loadingType: LoadingType.axial,
                cnsCost: CnsCost.medium,
                skillLevel: SkillLevel.intermediate,
                mechanics: Mechanics.compound,
                lottieUrl: const drift.Value(
                  'assets/lottie/exercises/bench_press.json',
                ),
                instructions: const drift.Value('Here are the instructions.'),
                tier: const drift.Value(ExerciseTier.curated),
                confidence: const drift.Value(1.0),
                createdAt: DateTime.now().toIso8601String(),
                updatedAt: DateTime.now().toIso8601String(),
              ),
            );

        final exercise = await db.exerciseDao.getExerciseById(
          'test_lottie_exercise',
        );

        expect(exercise, isNotNull);
        expect(exercise!.lottieUrl, 'assets/lottie/exercises/bench_press.json');
        expect(exercise.instructions, 'Here are the instructions.');
        expect(exercise.name, 'Lottie Exercise');
      },
    );
  });
}
