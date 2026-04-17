// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coaching_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoachingContext _$CoachingContextFromJson(Map<String, dynamic> json) =>
    _CoachingContext(
      weeklyVolume: (json['weeklyVolume'] as List<dynamic>)
          .map((e) => MuscleVolume.fromJson(e as Map<String, dynamic>))
          .toList(),
      movementPatternVolumes: (json['movementPatternVolumes'] as List<dynamic>)
          .map((e) => MovementPatternVolume.fromJson(e as Map<String, dynamic>))
          .toList(),
      topExercises: (json['topExercises'] as List<dynamic>)
          .map((e) => PerformanceSnapshot.fromJson(e as Map<String, dynamic>))
          .toList(),
      activeInjuries: (json['activeInjuries'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      fatigueScores: (json['fatigueScores'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      cardioSessions: (json['cardioSessions'] as List<dynamic>)
          .map((e) => CardioSessionMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCnsFatigue: (json['totalCnsFatigue'] as num).toDouble(),
      cnsLoadTrend: (json['cnsLoadTrend'] as List<dynamic>)
          .map((e) => CnsLoadSnapshot.fromJson(e as Map<String, dynamic>))
          .toList(),
      hrvMs: (json['hrvMs'] as num?)?.toDouble(),
      restingHr: (json['restingHr'] as num?)?.toInt(),
      sleepScore: (json['sleepScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoachingContextToJson(_CoachingContext instance) =>
    <String, dynamic>{
      'weeklyVolume': instance.weeklyVolume,
      'movementPatternVolumes': instance.movementPatternVolumes,
      'topExercises': instance.topExercises,
      'activeInjuries': instance.activeInjuries,
      'fatigueScores': instance.fatigueScores,
      'cardioSessions': instance.cardioSessions,
      'totalCnsFatigue': instance.totalCnsFatigue,
      'cnsLoadTrend': instance.cnsLoadTrend,
      'hrvMs': instance.hrvMs,
      'restingHr': instance.restingHr,
      'sleepScore': instance.sleepScore,
    };

_PerformanceSnapshot _$PerformanceSnapshotFromJson(Map<String, dynamic> json) =>
    _PerformanceSnapshot(
      exerciseName: json['exerciseName'] as String,
      oneRepMaxEstimate: (json['oneRepMaxEstimate'] as num).toDouble(),
      weeklyTrend: (json['weeklyTrend'] as num).toDouble(),
    );

Map<String, dynamic> _$PerformanceSnapshotToJson(
  _PerformanceSnapshot instance,
) => <String, dynamic>{
  'exerciseName': instance.exerciseName,
  'oneRepMaxEstimate': instance.oneRepMaxEstimate,
  'weeklyTrend': instance.weeklyTrend,
};

_MuscleVolume _$MuscleVolumeFromJson(Map<String, dynamic> json) =>
    _MuscleVolume(
      muscleName: json['muscleName'] as String,
      volume: (json['volume'] as num).toDouble(),
    );

Map<String, dynamic> _$MuscleVolumeToJson(_MuscleVolume instance) =>
    <String, dynamic>{
      'muscleName': instance.muscleName,
      'volume': instance.volume,
    };

_MovementPatternVolume _$MovementPatternVolumeFromJson(
  Map<String, dynamic> json,
) => _MovementPatternVolume(
  pattern: json['pattern'] as String,
  volume: (json['volume'] as num).toDouble(),
);

Map<String, dynamic> _$MovementPatternVolumeToJson(
  _MovementPatternVolume instance,
) => <String, dynamic>{'pattern': instance.pattern, 'volume': instance.volume};

_CnsLoadSnapshot _$CnsLoadSnapshotFromJson(Map<String, dynamic> json) =>
    _CnsLoadSnapshot(
      date: DateTime.parse(json['date'] as String),
      load: (json['load'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$CnsLoadSnapshotToJson(_CnsLoadSnapshot instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'load': instance.load,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_CardioSessionMetric _$CardioSessionMetricFromJson(Map<String, dynamic> json) =>
    _CardioSessionMetric(
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      heartRate: (json['heartRate'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CardioSessionMetricToJson(
  _CardioSessionMetric instance,
) => <String, dynamic>{
  'distance': instance.distance,
  'duration': instance.duration,
  'heartRate': instance.heartRate,
};
