import 'dart:typed_data';
import 'package:drift/drift.dart';
import 'database.dart';
import 'ontology_tables.dart';
import 'exercise_dao.dart';
import '../../domain/models/ontology_models.dart';

part 'substitution_dao.g.dart';

@DriftAccessor(tables: [Exercises])
class SubstitutionDao extends DatabaseAccessor<AppDatabase>
    with _$SubstitutionDaoMixin {
  SubstitutionDao(super.db);

  ExerciseDao get _exerciseDao => attachedDatabase.exerciseDao;

  /// Performs a high-performance raw SQL vector join combined with strict constraints.
  ///
  /// The query mathematically computes vector similarity while explicitly omitting
  /// any excluded equipment IDs and rejected/injured exercise IDs (Stage 1 Safety),
  /// applying the Equipment-First bottleneck directly in SQLite via sqlite-vec.
  Future<List<MapEntry<Exercise, double>>> getFilteredSubstitutions({
    required String originalExerciseId,
    required Float32List targetVector,
    required List<String> excludedEquipmentIds,
    required List<String> excludedExerciseIds,
    required int limit,
  }) async {
    final hasExcludedEquip = excludedEquipmentIds.isNotEmpty;
    final equipPlaceholders = hasExcludedEquip
        ? List.filled(excludedEquipmentIds.length, '?').join(',')
        : '';
        
    final hasExcludedEx = excludedExerciseIds.isNotEmpty;
    final exPlaceholders = hasExcludedEx
        ? List.filled(excludedExerciseIds.length, '?').join(',')
        : '';

    // SQLite-Vec v0.9+ syntax using vec_distance_cosine and vector_as_f32()
    final sql = '''
      SELECT e.*, vec_distance_cosine(v.vector, vector_as_f32(?)) AS vector_distance
      FROM exercise_vectors v
      JOIN exercises e ON e.id = v.exercise_id
      WHERE e.id != ?
        ${hasExcludedEquip ? 'AND e.equipment_id NOT IN ($equipPlaceholders)' : ''}
        ${hasExcludedEx ? 'AND e.id NOT IN ($exPlaceholders)' : ''}
      ORDER BY vector_distance ASC
      LIMIT ?;
    ''';

    final variables = <Variable>[
      Variable.withBlob(targetVector.buffer.asUint8List()),
      Variable.withString(originalExerciseId),
    ];

    if (hasExcludedEquip) {
      variables.addAll(
        excludedEquipmentIds.map((id) => Variable.withString(id)),
      );
    }
    
    if (hasExcludedEx) {
      variables.addAll(
        excludedExerciseIds.map((id) => Variable.withString(id)),
      );
    }

    variables.add(Variable.withInt(limit));

    final results = await customSelect(sql, variables: variables).get();

    return Future.wait(
      results.map((row) async {
        // mapFromRow returns the Drift-generated ExerciseData; hydrate to domain Exercise.
        final exerciseData = await exercises.mapFromRow(row);
        final exercise = await _exerciseDao.hydrateExercise(exerciseData);
        final distance = row.read<double>('vector_distance');
        return MapEntry(exercise, distance);
      }),
    );
  }
}
