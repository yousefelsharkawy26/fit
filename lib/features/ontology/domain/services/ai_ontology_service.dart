import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/enums/ontology_enums.dart';

/// Predicts exercise metadata based on the name using AI.
///
/// In production, this calls a Supabase Edge Function which uses
/// Gemini/GPT to infer the 9+1 ontological dimensions from a string.
class AIOntologyService {
  AIOntologyService();

  /// Infer metadata from name.
  /// Currently returns a deterministic guess or hits the network.
  Future<ExerciseMetadataSuggestion?> infer(String name) async {
    if (name.isEmpty) return null;

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock logic for "high-velocity" demo.
    // Real implementation would use:
    // final response = await supabase.functions.invoke('infer-exercise', body: {'name': name});

    final lowerName = name.toLowerCase();

    if (lowerName.contains('press')) {
      return ExerciseMetadataSuggestion(
        pattern: MovementPattern.push,
        angle: lowerName.contains('incline')
            ? ExerciseAngle.incline
            : ExerciseAngle.flat,
        laterality: Laterality.bilateral,
        mechanics: Mechanics.compound,
        loading: LoadingType.axial,
        plane: PlaneOfMotion.sagittal,
      );
    } else if (lowerName.contains('row') || lowerName.contains('pull')) {
      return ExerciseMetadataSuggestion(
        pattern: MovementPattern.pull,
        angle: ExerciseAngle.flat,
        laterality: lowerName.contains('arm')
            ? Laterality.unilateral
            : Laterality.bilateral,
        mechanics: Mechanics.compound,
        loading: LoadingType.peripheral,
        plane: PlaneOfMotion.sagittal,
      );
    } else if (lowerName.contains('squat') || lowerName.contains('lunge')) {
      return ExerciseMetadataSuggestion(
        pattern: MovementPattern.squat,
        angle: ExerciseAngle.flat,
        laterality: lowerName.contains('split') || lowerName.contains('lunge')
            ? Laterality.unilateral
            : Laterality.bilateral,
        mechanics: Mechanics.compound,
        loading: LoadingType.axial,
        plane: PlaneOfMotion.sagittal,
      );
    }

    return null;
  }
}

class ExerciseMetadataSuggestion {
  final MovementPattern? pattern;
  final ExerciseAngle? angle;
  final Laterality? laterality;
  final Mechanics? mechanics;
  final LoadingType? loading;
  final PlaneOfMotion? plane;

  ExerciseMetadataSuggestion({
    this.pattern,
    this.angle,
    this.laterality,
    this.mechanics,
    this.loading,
    this.plane,
  });
}

final aiOntologyServiceProvider = Provider<AIOntologyService>((ref) {
  return AIOntologyService();
});
