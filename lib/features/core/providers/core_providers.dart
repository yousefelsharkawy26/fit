import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:fit/features/ontology/data/database/database.dart';
import 'package:fit/features/ontology/data/database/exercise_dao.dart';
import 'package:fit/features/ontology/data/repository/vector_repository.dart';
import 'package:fit/features/ontology/data/vectorizer/vector_compute_service.dart';
import 'package:fit/features/ontology/domain/models/ontology_models.dart';
import 'package:fit/features/ontology/domain/services/substitution_service.dart';

// ---------------------------------------------------------------------------
// Database — singleton, keep-alive across the app lifetime.
// ---------------------------------------------------------------------------

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// ---------------------------------------------------------------------------
// DAOs — derived from the singleton database.
// ---------------------------------------------------------------------------

final exerciseDaoProvider = Provider<ExerciseDao>((ref) {
  return ref.watch(appDatabaseProvider).exerciseDao;
});

// ---------------------------------------------------------------------------
// Repository & Vectorizer layer.
// ---------------------------------------------------------------------------

final vectorRepositoryProvider = Provider<VectorRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final compute = ref.watch(vectorComputeServiceProvider);
  return VectorRepository(db, compute);
});

final vectorComputeServiceProvider = Provider<VectorComputeService>((ref) {
  return VectorComputeService();
});

// ---------------------------------------------------------------------------
// Substitution service (3-stage pipeline).
// ---------------------------------------------------------------------------

final substitutionServiceProvider = Provider<SubstitutionService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return SubstitutionService(
    db.exerciseDao,
    db.substitutionDao,
    ref.watch(vectorRepositoryProvider),
    ref.watch(vectorComputeServiceProvider),
  );
});

// ---------------------------------------------------------------------------
// Substitution results & constraint providers used by the Safety Center /
// Constraint Chips widgets.
// ---------------------------------------------------------------------------

/// The current substitution search constraints (equipment exclusion, etc.)
/// used by the Safety Center screen.
final substitutionConstraintsProvider =
    StateProvider<SubstitutionConstraints>((ref) => SubstitutionConstraints.empty);

/// Single-shot provider: run the full 3-stage pipeline for a given exercise.
final substitutionResultsProvider =
    FutureProvider.family<List<SubstitutionResult>, String>((ref, exerciseId) async {
  final db = ref.watch(appDatabaseProvider);
  final constraints = ref.watch(substitutionConstraintsProvider);
  final service = ref.watch(substitutionServiceProvider);

  final exercise = await db.exerciseDao.getExerciseById(exerciseId);
  if (exercise == null) return [];

  return service.findSubstitutions(
    sourceExercise: exercise,
    currentUserId: 'local-user',
    constraints: constraints,
  );
});

/// Fetch a single fully-hydrated exercise by ID.
final exerciseDetailProvider =
    FutureProvider.family<Exercise?, String>((ref, exerciseId) async {
  final db = ref.watch(appDatabaseProvider);
  return db.exerciseDao.getExerciseById(exerciseId);
});
