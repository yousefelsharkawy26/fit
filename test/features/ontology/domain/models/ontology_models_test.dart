import 'package:flutter_test/flutter_test.dart';
import 'package:fit/features/ontology/domain/models/ontology_models.dart';
import 'package:fit/features/ontology/domain/enums/ontology_enums.dart';

void main() {
  group('Exercise Model Tests', () {
    test('Exercise model supports lottieUrl and instructions', () {
      final now = DateTime.now().toIso8601String();
      final exercise = Exercise(
        id: 'test_exercise',
        name: 'Test Exercise',
        primaryMuscleId: 'pecs',
        equipment: const EquipmentModel(id: 'barbell', name: 'Barbell'),
        muscles: const [
          ExerciseMuscle(
            muscle: MuscleRegion(id: 'pecs', name: 'Pectorals', muscleGroup: 'Chest', displayOrder: 1),
            role: MuscleRole.primary,
          ),
        ],
        aliases: const [],
        movementPattern: MovementPattern.push,
        angle: ExerciseAngle.flat,
        laterality: Laterality.bilateral,
        loadingType: LoadingType.axial,
        cnsCost: CnsCost.medium,
        skillLevel: SkillLevel.intermediate,
        mechanics: Mechanics.compound,
        lottieUrl: 'assets/lottie/exercises/test.json',
        instructions: 'Push the weight up.',
        tier: ExerciseTier.curated,
        confidence: 1.0,
        createdAt: now,
        updatedAt: now,
      );

      expect(exercise.lottieUrl, 'assets/lottie/exercises/test.json');
      expect(exercise.instructions, 'Push the weight up.');
    });

    test('Exercise model allows null lottieUrl and instructions', () {
      final now = DateTime.now().toIso8601String();
      final exercise = Exercise(
        id: 'test_exercise_null',
        name: 'Test Exercise Null',
        primaryMuscleId: 'pecs',
        equipment: const EquipmentModel(id: 'barbell', name: 'Barbell'),
        muscles: const [],
        aliases: const [],
        movementPattern: MovementPattern.push,
        angle: ExerciseAngle.flat,
        laterality: Laterality.bilateral,
        loadingType: LoadingType.axial,
        cnsCost: CnsCost.medium,
        skillLevel: SkillLevel.intermediate,
        mechanics: Mechanics.compound,
        tier: ExerciseTier.curated,
        confidence: 1.0,
        createdAt: now,
        updatedAt: now,
      );

      expect(exercise.lottieUrl, isNull);
      expect(exercise.instructions, isNull);
    });
  });
}
