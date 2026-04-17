import 'dart:typed_data';
import 'dart:isolate';

import '../../domain/models/ontology_models.dart';
import 'exercise_vectorizer.dart';

class VectorComputeService {
  static const _vectorizer = ExerciseVectorizer();

  Float32List computeSync(Exercise exercise) {
    return _vectorizer.encode(exercise);
  }

  Future<Float32List> generateVector(Exercise exercise) async {
    return compute(exercise);
  }

  Future<Float32List> compute(Exercise exercise) async {
    return Isolate.run(() {
      const vectorizer = ExerciseVectorizer();
      return vectorizer.encode(exercise);
    });
  }

  Future<Map<String, Float32List>> computeBatch(
    List<Exercise> exercises,
  ) async {
    if (exercises.isEmpty) return {};

    if (exercises.length <= 5) {
      return {
        for (final ex in exercises)
          ex.id: _vectorizer.encode(ex),
      };
    }

    return Isolate.run(() {
      const vectorizer = ExerciseVectorizer();
      return {
        for (final ex in exercises)
          ex.id: vectorizer.encode(ex),
      };
    });
  }

  String debugExerciseVector(Exercise exercise) {
    final vector = _vectorizer.encode(exercise);
    return _vectorizer.debugVector(vector);
  }
}