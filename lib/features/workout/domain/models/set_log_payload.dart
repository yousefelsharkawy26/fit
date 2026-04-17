import '../../../coaching/data/database/coaching_tables.dart';

enum TrackingScheme {
  weightReps,
  distanceTime,
  weightDistance,
  weightTime,
  repsDistance,
  repsTime,
  weightOnly,
  repsOnly,
  timeOnly,
  distanceOnly,
  cardioFull,
}

enum TrackingField { weight, reps, distance, duration, heartRate }

class SetLogPayload {
  final TrackingScheme scheme;
  final double? weight;
  final int? reps;
  final double? rpe;
  final double? distance;
  final int? duration;
  final int? heartRate;
  final SetType setType;

  const SetLogPayload({
    required this.scheme,
    this.weight,
    this.reps,
    this.rpe,
    this.distance,
    this.duration,
    this.heartRate,
    this.setType = SetType.working,
  });

  TrackingType get trackingType => switch (scheme) {
    TrackingScheme.distanceTime ||
    TrackingScheme.weightDistance ||
    TrackingScheme.weightTime ||
    TrackingScheme.repsDistance ||
    TrackingScheme.repsTime ||
    TrackingScheme.timeOnly ||
    TrackingScheme.distanceOnly ||
    TrackingScheme.cardioFull => TrackingType.cardio,
    _ => TrackingType.strength,
  };

  bool hasRequiredFields() {
    final required = requiredFieldsForScheme(scheme);
    if (required.contains(TrackingField.weight) && weight == null) return false;
    if (required.contains(TrackingField.reps) && reps == null) return false;
    if (required.contains(TrackingField.distance) && distance == null) {
      return false;
    }
    if (required.contains(TrackingField.duration) && duration == null) {
      return false;
    }
    if (required.contains(TrackingField.heartRate) && heartRate == null) {
      return false;
    }
    return true;
  }
}

Set<TrackingField> requiredFieldsForScheme(TrackingScheme scheme) =>
    switch (scheme) {
      TrackingScheme.weightReps => {TrackingField.weight, TrackingField.reps},
      TrackingScheme.distanceTime => {
        TrackingField.distance,
        TrackingField.duration,
      },
      TrackingScheme.weightDistance => {
        TrackingField.weight,
        TrackingField.distance,
      },
      TrackingScheme.weightTime => {TrackingField.weight, TrackingField.duration},
      TrackingScheme.repsDistance => {TrackingField.reps, TrackingField.distance},
      TrackingScheme.repsTime => {TrackingField.reps, TrackingField.duration},
      TrackingScheme.weightOnly => {TrackingField.weight},
      TrackingScheme.repsOnly => {TrackingField.reps},
      TrackingScheme.timeOnly => {TrackingField.duration},
      TrackingScheme.distanceOnly => {TrackingField.distance},
      TrackingScheme.cardioFull => {
        TrackingField.distance,
        TrackingField.duration,
        TrackingField.heartRate,
      },
    };

String trackingSchemeLabel(TrackingScheme scheme) => switch (scheme) {
  TrackingScheme.weightReps => 'Weight + Reps',
  TrackingScheme.distanceTime => 'Distance + Time',
  TrackingScheme.weightDistance => 'Weight + Distance',
  TrackingScheme.weightTime => 'Weight + Time',
  TrackingScheme.repsDistance => 'Reps + Distance',
  TrackingScheme.repsTime => 'Reps + Time',
  TrackingScheme.weightOnly => 'Weight only',
  TrackingScheme.repsOnly => 'Reps only',
  TrackingScheme.timeOnly => 'Time only',
  TrackingScheme.distanceOnly => 'Distance only',
  TrackingScheme.cardioFull => 'Dist + Time + HR',
};
