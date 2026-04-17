// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BiomechanicalLoadSummary _$BiomechanicalLoadSummaryFromJson(
  Map<String, dynamic> json,
) => _BiomechanicalLoadSummary(
  movementPatternBalance:
      (json['movementPatternBalance'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
  cnsFatigueTrend: (json['cnsFatigueTrend'] as List<dynamic>)
      .map((e) => CnsLoadSnapshot.fromJson(e as Map<String, dynamic>))
      .toList(),
  muscleIntensity: (json['muscleIntensity'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  volumeTrend: (json['volumeTrend'] as List<dynamic>)
      .map((e) => PerformanceTrendPoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  intensityTrend: (json['intensityTrend'] as List<dynamic>)
      .map((e) => PerformanceTrendPoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  topExercises: (json['topExercises'] as List<dynamic>)
      .map((e) => PerformanceSnapshot.fromJson(e as Map<String, dynamic>))
      .toList(),
  weeklyVolumeLoad: (json['weeklyVolumeLoad'] as num).toDouble(),
  sessionCount: (json['sessionCount'] as num).toInt(),
  recoveryStatus: json['recoveryStatus'] as String,
);

Map<String, dynamic> _$BiomechanicalLoadSummaryToJson(
  _BiomechanicalLoadSummary instance,
) => <String, dynamic>{
  'movementPatternBalance': instance.movementPatternBalance,
  'cnsFatigueTrend': instance.cnsFatigueTrend,
  'muscleIntensity': instance.muscleIntensity,
  'volumeTrend': instance.volumeTrend,
  'intensityTrend': instance.intensityTrend,
  'topExercises': instance.topExercises,
  'weeklyVolumeLoad': instance.weeklyVolumeLoad,
  'sessionCount': instance.sessionCount,
  'recoveryStatus': instance.recoveryStatus,
};

_PerformanceTrendPoint _$PerformanceTrendPointFromJson(
  Map<String, dynamic> json,
) => _PerformanceTrendPoint(
  date: DateTime.parse(json['date'] as String),
  value: (json['value'] as num).toDouble(),
);

Map<String, dynamic> _$PerformanceTrendPointToJson(
  _PerformanceTrendPoint instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'value': instance.value,
};
