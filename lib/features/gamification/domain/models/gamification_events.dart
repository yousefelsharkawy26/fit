// Gamification Events


sealed class GamificationEvent {}

class PrAchievementEvent extends GamificationEvent {
  final String exerciseName;
  final double weight;
  final int reps;

  PrAchievementEvent({
    required this.exerciseName,
    required this.weight,
    required this.reps,
  });
}

class MuscleLevelUpEvent extends GamificationEvent {
  final String muscleRegionId;
  final int newLevel;

  MuscleLevelUpEvent({
    required this.muscleRegionId,
    required this.newLevel,
  });
}

class StreakShieldExpendedEvent extends GamificationEvent {
  final int remainingShields;
  final int currentStreak;

  StreakShieldExpendedEvent({
    required this.remainingShields,
    required this.currentStreak,
  });
}

class StreakMilestoneEvent extends GamificationEvent {
  final int streakDays;

  StreakMilestoneEvent({
    required this.streakDays,
  });
}
