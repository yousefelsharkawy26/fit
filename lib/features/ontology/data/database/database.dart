import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fit/features/ontology/domain/enums/ontology_enums.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite_vector/sqlite_vector.dart';

import 'ontology_converters.dart';
import 'ontology_tables.dart';
import 'exercise_dao.dart';
import 'ontology_seeder.dart';

import '../../../coaching/data/database/coaching_tables.dart';
import '../../../coaching/data/database/coaching_dao.dart';
import '../../../workout/data/database/workout_dao.dart';
import '../../../gamification/data/database/gamification_tables.dart';
import '../../../gamification/data/database/gamification_dao.dart';
import '../../../health/data/database/health_tables.dart';
import '../../../health/data/database/health_dao.dart';
import 'substitution_dao.dart';
import '../vectorizer/dimension_registry.dart';

part 'database.g.dart';

// ═══════════════════════════════════════════════════════
// VECTOR CONSTANTS — single source of truth
// ═══════════════════════════════════════════════════════

/// The vector dimension MUST match DimensionRegistry.totalDimensions (80).
final String _vectorInitOptions =
    'dimension=${DimensionRegistry.totalDimensions},type=FLOAT32,distance=COSINE';

@DriftDatabase(
  tables: [
    MuscleRegions,
    Equipment,
    Exercises,
    ExerciseMuscles,
    ExerciseAliases,
    SubstitutionFeedback,
    SyncQueue,
    UserPreferences,
    UserMuscleConstraints,
    Workouts,
    WorkoutExercises,
    WorkoutSets,
    UserStats,
    MuscleExperience,
    MigrationStatus,
    UserBiometrics,
    HealthSnapshots,
  ],
  daos: [
    ExerciseDao,
    CoachingDao,
    WorkoutDao,
    GamificationDao,
    SubstitutionDao,
    HealthDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 10;

  // ═══════════════════════════════════════════════════════
  // MIGRATIONS
  // ═══════════════════════════════════════════════════════
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();

        // ✅ Create vector table
        await _createVectorTable();

        // ✅ Seed initial ontology
        final seeder = OntologySeeder(this);
        await seeder.seedAll();

        debugPrint('✅ Database created + seeded');
      },

      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 3) {
          await m.createTable(migrationStatus);
        }

        if (from < 4) {
          await m.createTable(userBiometrics);
        }

        if (from < 5) {
          await _createVectorTable();
        }

        if (from < 6) {
          try {
            await m.addColumn(exercises, exercises.primaryMuscleId);
            await m.addColumn(exercises, exercises.planeOfMotion);
          } catch (_) {}
        }

        if (from < 7) {
          try {
            await m.addColumn(workoutSets, workoutSets.trackingType);
            await m.addColumn(workoutSets, workoutSets.distance); // was distanceMeters
            await m.addColumn(workoutSets, workoutSets.duration); // was durationSeconds
            await m.addColumn(workoutSets, workoutSets.heartRate); // was avgHeartRate
          } catch (_) {}
        }

        if (from < 8) {
          await m.createTable(healthSnapshots);
        }

        if (from < 9) {
          try {
            await m.addColumn(exercises, exercises.lottieUrl);
            await m.addColumn(exercises, exercises.instructions);
          } catch (_) {}
        }

        if (from < 10) {
          // Drop obsolete view that blocks ALTER TABLE (deleted from codebase in Phase 1)
          await customStatement('DROP VIEW IF EXISTS muscle_volume_calculations');

          // 1. Rename columns in WorkoutSets for Path C purity
          await m.renameColumn(workoutSets, 'distance_meters', workoutSets.distance);
          await m.renameColumn(workoutSets, 'duration_seconds', workoutSets.duration);
          await m.renameColumn(workoutSets, 'avg_heart_rate', workoutSets.heartRate);

          // 2. Make weight and reps nullable
          await m.alterTable(TableMigration(workoutSets));
        }

        debugPrint('🔄 Database upgraded: $from → $to');
      },

      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');

        // Debug: verify vector extension
        await _debugVectorEnvironment();
      },
    );
  }

  // ═══════════════════════════════════════════════════════
  // VECTOR TABLE
  // ═══════════════════════════════════════════════════════
  Future<void> _createVectorTable() async {
    await customStatement('''
      CREATE TABLE IF NOT EXISTS exercise_vectors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        exercise_id TEXT UNIQUE,
        vector BLOB NOT NULL
      )
    ''');

    debugPrint('🧬 Vector table ready');
  }

  // ═══════════════════════════════════════════════════════
  // DEBUG (SAFE)
  // ═══════════════════════════════════════════════════════
  Future<void> _debugVectorEnvironment() async {
    try {
      final modules = await customSelect(
        "SELECT name FROM pragma_module_list()",
      ).get();

      final moduleNames = modules.map((e) => e.read<String>('name')).toList();

      final functions = await customSelect(
        "SELECT name FROM pragma_function_list()",
      ).get();

      final functionNames = functions
          .map((e) => e.read<String>('name'))
          .toList();

      debugPrint('🧬 SQLite Modules: $moduleNames');
      debugPrint(
        '🧬 Vector Functions: ${functionNames.where((f) => f.contains("vector")).toList()}',
      );
    } catch (e) {
      debugPrint('⚠️ Debug vector environment failed: $e');
    }
  }
}

// ═══════════════════════════════════════════════════════
// EXTENSION LOADING — call ONCE at process lifetime
// ═══════════════════════════════════════════════════════

bool _extensionLoaded = false;

/// Loads the sqlite-vector native extension exactly once.
/// Must be called before any database is opened (e.g. in main()).
void ensureSqliteVectorLoaded() {
  if (_extensionLoaded) return;
  sqlite3.loadSqliteVectorExtension();
  _extensionLoaded = true;
  debugPrint('✅ sqlite-vector extension loaded via package API');
}

// ═══════════════════════════════════════════════════════
// CONNECTION SETUP
// ═══════════════════════════════════════════════════════
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // 1. Load extension BEFORE opening any database
    ensureSqliteVectorLoaded();

    final folder = await getApplicationDocumentsDirectory();
    final file = File(p.join(folder.path, 'fitos.db'));

    return NativeDatabase.createInBackground(
      file,
      setup: (rawDb) {
        // ═══════════════════════
        // 1. ENSURE TABLE EXISTS
        // ═══════════════════════
        try {
          rawDb.execute('''
            CREATE TABLE IF NOT EXISTS exercise_vectors (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              exercise_id TEXT UNIQUE,
              vector BLOB NOT NULL
            )
          ''');
        } catch (e) {
          debugPrint('❌ table creation failed: $e');
        }

        // ═══════════════════════
        // 2. INIT VECTOR CONTEXT (per-connection, required by API)
        // ═══════════════════════
        try {
          rawDb.execute(
            "SELECT vector_init('exercise_vectors', 'vector', '$_vectorInitOptions')",
          );
          debugPrint('🧬 vector_init OK (dim=${DimensionRegistry.totalDimensions})');
        } catch (e) {
          debugPrint('⚠️ vector_init deferred: $e');
        }
      },
    );
  });
}

