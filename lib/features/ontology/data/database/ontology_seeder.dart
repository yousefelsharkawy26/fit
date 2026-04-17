import 'package:drift/drift.dart';

import '../../domain/enums/ontology_enums.dart';

import 'database.dart';
import '../seed/muscle_regions_seed.dart';
import '../seed/equipment_seed.dart';
import '../seed/exercises_seed.dart';

/// Seeds the ontology database with Tier 1 ground truth data.
///
/// This runs on first launch to populate:
///   - 25 muscle regions
///   - 8 equipment types
///   - 50 curated exercises with muscle junctions and aliases
///
/// Seed data is idempotent — re-running it will not create duplicates
/// (uses INSERT OR IGNORE via onConflict).
///
/// See: exercise_ontology_design.md §4 — Database Schema
class OntologySeeder {
  final AppDatabase _db;

  OntologySeeder(this._db);

  /// Run all seed operations in a single transaction.
  Future<void> seedAll() async {
    await _db.transaction(() async {
      await _seedMuscleRegions();
      await _seedEquipment();
      await _seedExercises();
    });
  }

  /// Seed the muscle_regions table (~25 entries).
  Future<void> _seedMuscleRegions() async {
    for (final region in MuscleRegionSeed.data) {
      await _db.into(_db.muscleRegions).insertOnConflictUpdate(
        MuscleRegionsCompanion.insert(
          id: region['id'] as String,
          name: region['name'] as String,
          muscleGroup: region['muscle_group'] as String,
          displayOrder: Value(region['display_order'] as int),
        ),
      );
    }
  }

  /// Seed the equipment table (~8 entries).
  Future<void> _seedEquipment() async {
    for (final eq in EquipmentSeed.data) {
      await _db.into(_db.equipment).insertOnConflictUpdate(
        EquipmentCompanion.insert(
          id: eq['id'] as String,
          name: eq['name'] as String,
          icon: Value(eq['icon'] as String?),
        ),
      );
    }
  }

  /// Seed exercises, their muscle junctions, and aliases.
  Future<void> _seedExercises() async {
    int aliasCounter = 0;

    for (final entry in ExercisesSeed.data) {
      final exerciseData = entry['exercise'] as Map<String, dynamic>;
      final musclesData = entry['muscles'] as List<Map<String, dynamic>>;
      final aliasesData = entry['aliases'] as List<String>;

      // Insert exercise
      await _db.into(_db.exercises).insertOnConflictUpdate(
        ExercisesCompanion.insert(
          id: exerciseData['id'] as String,
          name: exerciseData['name'] as String,
          equipmentId: exerciseData['equipment_id'] as String,
          primaryMuscleId: exerciseData['primary_muscle'] as String,
          movementPattern: MovementPattern.fromString(exerciseData['movement_pattern'] as String),
          planeOfMotion: exerciseData['plane_of_motion'] != null
              ? Value(PlaneOfMotion.fromString(exerciseData['plane_of_motion'] as String))
              : const Value.absent(),
          angle: ExerciseAngle.fromString(exerciseData['angle'] as String),
          laterality: Laterality.fromString(exerciseData['laterality'] as String),
          loadingType: LoadingType.fromString(exerciseData['loading_type'] as String),
          cnsCost: CnsCost.fromString(exerciseData['cns_cost'] as String),
          skillLevel: SkillLevel.fromString(exerciseData['skill_level'] as String),
          mechanics: Mechanics.fromString(exerciseData['mechanics'] as String),
          tier: Value(ExerciseTier.fromValue(exerciseData['tier'] as int)),
          confidence: Value(exerciseData['confidence'] as double),
          canonicalHash: Value(exerciseData['canonical_hash'] as String?),
          createdBy: Value(exerciseData['created_by'] as String?),
          createdAt: exerciseData['created_at'] as String,
          updatedAt: exerciseData['updated_at'] as String,
        ),
      );

      // Insert muscle junctions
      for (final muscle in musclesData) {
        await _db.into(_db.exerciseMuscles).insertOnConflictUpdate(
          ExerciseMusclesCompanion.insert(
            exerciseId: exerciseData['id'] as String,
            muscleId: muscle['muscle_id'] as String,
            role: MuscleRole.fromString(muscle['role'] as String),
          ),
        );
      }

      // Insert aliases
      for (int i = 0; i < aliasesData.length; i++) {
        aliasCounter++;
        final aliasId = 'alias-${aliasCounter.toString().padLeft(4, '0')}';
        await _db.into(_db.exerciseAliases).insertOnConflictUpdate(
          ExerciseAliasesCompanion.insert(
            id: aliasId,
            exerciseId: exerciseData['id'] as String,
            aliasName: aliasesData[i],
            isPrimary: Value(i == 0), // first alias is the canonical name
          ),
        );
      }
    }
  }

  /// Getter helpers for table references (must be overridden by the actual DB)
  // Note: These are provided by the generated database class when used
  // via DatabaseConnectionUser. The actual accessors come from AppDatabase.
}
