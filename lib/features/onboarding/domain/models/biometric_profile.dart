import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometric_profile.freezed.dart';
part 'biometric_profile.g.dart';

enum ExperienceLevel { novice, intermediate, advanced }

enum PrimaryGoal { hypertrophy, strength, endurance, recomp }

@freezed
abstract class BiometricProfile with _$BiometricProfile {
  const factory BiometricProfile({
    ExperienceLevel? experienceLevel,
    PrimaryGoal? primaryGoal,
    @Default([]) List<String> availableEquipmentIds,
    double? weight,
    double? height,
    int? age,
  }) = _BiometricProfile;

  factory BiometricProfile.fromJson(Map<String, dynamic> json) =>
      _$BiometricProfileFromJson(json);
}
