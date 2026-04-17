// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HealthSnapshot _$HealthSnapshotFromJson(Map<String, dynamic> json) =>
    _HealthSnapshot(
      id: json['id'] as String,
      userId: json['userId'] as String,
      hrvMs: (json['hrvMs'] as num?)?.toDouble(),
      restingHr: (json['restingHr'] as num?)?.toInt(),
      sleepScore: (json['sleepScore'] as num?)?.toDouble(),
      sleepDurationMinutes: (json['sleepDurationMinutes'] as num?)?.toInt(),
      syncSource: $enumDecode(_$HealthSyncSourceEnumMap, json['syncSource']),
      syncedAt: DateTime.parse(json['syncedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$HealthSnapshotToJson(_HealthSnapshot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'hrvMs': instance.hrvMs,
      'restingHr': instance.restingHr,
      'sleepScore': instance.sleepScore,
      'sleepDurationMinutes': instance.sleepDurationMinutes,
      'syncSource': _$HealthSyncSourceEnumMap[instance.syncSource]!,
      'syncedAt': instance.syncedAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$HealthSyncSourceEnumMap = {
  HealthSyncSource.apple: 'apple',
  HealthSyncSource.google: 'google',
  HealthSyncSource.manual: 'manual',
};
