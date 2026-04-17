class OverloadPrescription {
  final double targetWeight;
  final int targetReps;
  final double targetRpe;
  final String rationaleNote;
  final bool isDiscovery;

  const OverloadPrescription({
    required this.targetWeight,
    required this.targetReps,
    required this.targetRpe,
    required this.rationaleNote,
    this.isDiscovery = false,
  });

  @override
  String toString() {
    if (isDiscovery) return 'Discovery Set: $rationaleNote';
    return '${targetWeight}kg x $targetReps @ RPE $targetRpe ($rationaleNote)';
  }
}
