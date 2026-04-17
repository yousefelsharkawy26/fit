import 'package:flutter/material.dart';
import '../../../common/design_tokens.dart';

enum FatigueLevel {
  undertrained,
  optimal,
  overreaching,
  danger,
}

class MuscleFatigueState {
  final String muscleGroup;
  final double acwr;
  final FatigueLevel level;
  final Color color;
  final bool isPulsing;

  const MuscleFatigueState({
    required this.muscleGroup,
    required this.acwr,
    required this.level,
    required this.color,
    this.isPulsing = false,
  });

  factory MuscleFatigueState.fromACWR(String muscleGroup, double acwr) {
    if (acwr > 1.5) {
      return MuscleFatigueState(
        muscleGroup: muscleGroup,
        acwr: acwr,
        level: FatigueLevel.danger,
        color: StyleSeedColors.accentPink,
        isPulsing: true,
      );
    } else if (acwr > 1.2) {
      return MuscleFatigueState(
        muscleGroup: muscleGroup,
        acwr: acwr,
        level: FatigueLevel.overreaching,
        color: StyleSeedColors.borderWarning,
      );
    } else if (acwr >= 0.8) {
      return MuscleFatigueState(
        muscleGroup: muscleGroup,
        acwr: acwr,
        level: FatigueLevel.optimal,
        color: StyleSeedColors.accentCyan,
      );
    } else {
      return MuscleFatigueState(
        muscleGroup: muscleGroup,
        acwr: acwr,
        level: FatigueLevel.undertrained,
        color: StyleSeedColors.textSecondary.withValues(alpha: 0.5),
      );
    }
  }
}
