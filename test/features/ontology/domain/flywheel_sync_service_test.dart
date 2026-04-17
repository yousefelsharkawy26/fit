import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:fit/features/ontology/domain/services/flywheel_sync_service.dart';
import 'package:fit/features/ontology/data/database/exercise_dao.dart';
import 'package:fit/features/ontology/data/sync/flywheel_client.dart';
import 'package:fit/features/ontology/data/sync/mock_flywheel_client.dart';
import 'package:fit/features/ontology/domain/enums/ontology_enums.dart';
import 'package:fit/features/ontology/domain/models/ontology_models.dart';
import 'package:fit/features/ontology/data/database/database.dart';
import 'package:fit/features/ontology/presentation/providers/ontology_data_providers.dart';

@GenerateNiceMocks([MockSpec<ExerciseDao>()])
import 'flywheel_sync_service_test.mocks.dart';

void main() {
  group('FlywheelSyncService Library Merge', () {
    late ProviderContainer container;
    late MockExerciseDao mockDao;

    setUp(() {
      mockDao = MockExerciseDao();
      container = ProviderContainer(
        overrides: [exerciseDaoProvider.overrideWithValue(mockDao)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('updates exercise to Tier 1 and creates alias on promotion', () async {
      final service = container.read(flywheelSyncServiceProvider);

      final globalExercise = Exercise(
        id: const Uuid().v4(),
        name: 'Barbell Back Squat',
        canonicalHash: 'HASH_SQUAT_V1',
        equipment: const EquipmentModel(id: 'barbell', name: 'Barbell'),
        muscles: const [],
        aliases: const [],
        movementPattern: MovementPattern.squat,
        angle: ExerciseAngle.flat,
        laterality: Laterality.bilateral,
        loadingType: LoadingType.axial,
        cnsCost: CnsCost.high,
        skillLevel: SkillLevel.intermediate,
        mechanics: Mechanics.compound,
        tier: ExerciseTier.curated,
        confidence: 1.0,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        primaryMuscleId: const Uuid().v4(),
      );

      when(mockDao.updateExercise(any, any)).thenAnswer((_) async {});
      when(mockDao.insertAlias(any)).thenAnswer((_) async {});

      await service.handleLibraryMerge(
        localExerciseId: 'LOCAL_ID_123',
        globalTier1Definition: globalExercise,
        oldLocalName: 'My Leg Bend',
      );

      verify(
        mockDao.updateExercise(
          'LOCAL_ID_123',
          argThat(isA<ExercisesCompanion>()),
        ),
      ).called(1);

      verify(
        mockDao.insertAlias(argThat(isA<ExerciseAliasesCompanion>())),
      ).called(1);
    });

    test('preserves old local name as non-primary alias', () async {
      final service = container.read(flywheelSyncServiceProvider);

      final globalExercise = Exercise(
        id: const Uuid().v4(),
        name: 'Romanian Deadlift',
        canonicalHash: 'HASH_RDL_V1',
        equipment: const EquipmentModel(id: 'barbell', name: 'Barbell'),
        muscles: const [],
        aliases: const [],
        movementPattern: MovementPattern.hinge,
        angle: ExerciseAngle.flat,
        laterality: Laterality.bilateral,
        loadingType: LoadingType.axial,
        cnsCost: CnsCost.high,
        skillLevel: SkillLevel.intermediate,
        mechanics: Mechanics.compound,
        tier: ExerciseTier.curated,
        confidence: 1.0,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        primaryMuscleId: const Uuid().v4(),
      );

      when(mockDao.updateExercise(any, any)).thenAnswer((_) async {});

      ExerciseAliasesCompanion? capturedAlias;
      when(mockDao.insertAlias(any)).thenAnswer((invocation) async {
        capturedAlias =
            invocation.positionalArguments[0] as ExerciseAliasesCompanion;
      });

      await service.handleLibraryMerge(
        localExerciseId: 'LOCAL_RDL',
        globalTier1Definition: globalExercise,
        oldLocalName: 'Stiff-Legged DL',
      );

      expect(capturedAlias, isNotNull);
      expect(capturedAlias!.aliasName.value, equals('Stiff-Legged DL'));
      expect(capturedAlias!.isPrimary.value, isFalse);
      expect(capturedAlias!.exerciseId.value, equals('LOCAL_RDL'));
    });
  });

  group('MockFlywheelClient', () {
    late MockFlywheelClient client;

    setUp(() {
      client = MockFlywheelClient(minLatencyMs: 0, maxLatencyMs: 1);
    });

    tearDown(() {
      client.dispose();
    });

    test('tracks submissions and computes consensus', () async {
      final result = await client.submitExerciseVariant(
        sanitizedPayload: {
          'canonical_hash': 'HASH_A',
          'exercise_name': 'Test Exercise',
        },
      );

      expect(result.submissionCount, equals(1));
      expect(
        result.communityConfidence,
        equals(1 / GlobalConsensusResult.promotionThreshold),
      );
      expect(result.isPromotedToTier1, isFalse);
    });

    test('promotes to Tier 1 at threshold', () async {
      bool promotionFired = false;
      client.listenToPromotions((_) => promotionFired = true);

      for (int i = 0; i < GlobalConsensusResult.promotionThreshold; i++) {
        await client.submitExerciseVariant(
          sanitizedPayload: {
            'canonical_hash': 'HASH_B',
            'exercise_name': 'Promoted Exercise',
          },
        );
      }

      final consensus = await client.getConsensus('HASH_B');
      expect(consensus, isNotNull);
      expect(consensus!.isPromotedToTier1, isTrue);
      expect(consensus.communityConfidence, equals(1.0));
      expect(promotionFired, isTrue);
    });

    test('tracks rejections per source exercise', () async {
      await client.reportRejection(
        sourceExerciseId: 'EX_1',
        rejectedExerciseId: 'EX_2',
      );
      await client.reportRejection(
        sourceExerciseId: 'EX_1',
        rejectedExerciseId: 'EX_3',
      );

      expect(client.rejections['EX_1'], containsAll(['EX_2', 'EX_3']));
    });

    test('returns null consensus for unknown hash', () async {
      final result = await client.getConsensus('NONEXISTENT');
      expect(result, isNull);
    });

    test('seed consensus initializes pool', () async {
      client.seedConsensus({'HASH_X': 3});
      final result = await client.getConsensus('HASH_X');
      expect(result, isNotNull);
      expect(result!.submissionCount, equals(3));
    });
  });

  group('GlobalConsensusResult', () {
    test('fromCount clamps confidence at 1.0', () {
      final result = GlobalConsensusResult.fromCount(100);
      expect(result.communityConfidence, equals(1.0));
      expect(result.isPromotedToTier1, isTrue);
    });

    test('fromCount at zero', () {
      final result = GlobalConsensusResult.fromCount(0);
      expect(result.communityConfidence, equals(0.0));
      expect(result.isPromotedToTier1, isFalse);
    });
  });
}
