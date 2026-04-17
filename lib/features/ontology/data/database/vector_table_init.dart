import '../vectorizer/dimension_registry.dart';
import 'database.dart';

/// Initializes the `sqlite_vector` extension and creates the
/// `exercise_vectors` table for vector similarity search.
///
/// **NOTE**: This class is used only for explicit re-initialization.
/// Normal per-connection init happens in `database.dart`'s `setup` callback.
///
/// See: exercise_ontology_design.md §5 — Vector Search
class VectorTableInit {
  final AppDatabase db;

  VectorTableInit(this.db);

  /// The canonical vector_init options string.
  static final String vectorInitOptions =
      'dimension=${DimensionRegistry.totalDimensions},type=FLOAT32,distance=COSINE';

  Future<void> initialize() async {
    // 1. Create a standard table for storing vectors.
    // Note: It MUST have a rowid (implicit or explicit INTEGER PRIMARY KEY).
    await db.customStatement('''
      CREATE TABLE IF NOT EXISTS exercise_vectors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        exercise_id TEXT UNIQUE NOT NULL,
        vector BLOB NOT NULL
      );
    ''');

    // 2. Initialize the vector extension for this column.
    // This MUST be called for every connection, but calling it here
    // ensures the metadata is set up.
    await db.customSelect(
      "SELECT vector_init('exercise_vectors', 'vector', '$vectorInitOptions')",
    ).get();
  }
}
