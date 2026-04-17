// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BiometricProfile _$BiometricProfileFromJson(Map<String, dynamic> json) =>
    _BiometricProfile(
      experienceLevel: $enumDecodeNullable(
        _$ExperienceLevelEnumMap,
        json['experienceLevel'],
      ),
      primaryGoal: $enumDecodeNullable(
        _$PrimaryGoalEnumMap,
        json['primaryGoal'],
      ),
      availableEquipmentIds:
          (json['availableEquipmentIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      age: (json['age'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BiometricProfileToJson(_BiometricProfile instance) =>
    <String, dynamic>{
      'experienceLevel': _$ExperienceLevelEnumMap[instance.experienceLevel],
      'primaryGoal': _$PrimaryGoalEnumMap[instance.primaryGoal],
      'availableEquipmentIds': instance.availableEquipmentIds,
      'weight': instance.weight,
      'height': instance.height,
      'age': instance.age,
    };

const _$ExperienceLevelEnumMap = {
  ExperienceLevel.novice: 'novice',
  ExperienceLevel.intermediate: 'intermediate',
  ExperienceLevel.advanced: 'advanced',
};

const _$PrimaryGoalEnumMap = {
  PrimaryGoal.hypertrophy: 'hypertrophy',
  PrimaryGoal.strength: 'strength',
  PrimaryGoal.endurance: 'endurance',
  PrimaryGoal.recomp: 'recomp',
};
