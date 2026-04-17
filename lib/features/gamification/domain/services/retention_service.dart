import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../data/database/gamification_dao.dart';
import '../../../ontology/data/database/database.dart';
import '../../presentation/providers/gamification_providers.dart';
import '../models/gamification_events.dart';
import 'gamification_notification_service.dart';

final retentionServiceProvider = Provider<RetentionService>((ref) {
  return RetentionService(
    dao: ref.read(gamificationDaoProvider),
    notificationService: ref.read(gamificationNotificationProvider.notifier),
  );
});

class RetentionService {
  final GamificationDao _dao;
  final GamificationNotificationService _notificationService;

  RetentionService({
    required GamificationDao dao,
    required GamificationNotificationService notificationService,
  }) : _dao = dao,
       _notificationService = notificationService;

  /// Updates the user's streak after completing a workout.
  Future<void> updateStreakAfterWorkout(String userId) async {
    final stats = await _dao.getUserStats(userId);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (stats == null) {
      // First workout ever
      await _dao.upsertUserStats(UserStatsCompanion.insert(
        userId: Value(userId),
        currentStreak: const Value(1),
        longestStreak: const Value(1),
        lastWorkoutDate: Value(today),
      ));
      return;
    }

    final lastDate = stats.lastWorkoutDate;
    if (lastDate == null) {
      await _dao.upsertUserStats(stats.toCompanion(false).copyWith(
        currentStreak: const Value(1),
        lastWorkoutDate: Value(today),
      ));
      return;
    }

    final lastWorkoutDay = DateTime(lastDate.year, lastDate.month, lastDate.day);
    final difference = today.difference(lastWorkoutDay).inDays;

    if (difference == 0) {
      // Already worked out today, no streak change
      return;
    } else if (difference == 1) {
      // Consecutive day
      final newStreak = stats.currentStreak + 1;

      // Notify of a streak milestone! (every 5 days, or just send it and let UI decide to celebrate every multiple of 3/5/etc)
      if (newStreak % 5 == 0 || newStreak == 3) {
        _notificationService.addEvent(StreakMilestoneEvent(streakDays: newStreak));
      }

      await _dao.upsertUserStats(stats.toCompanion(false).copyWith(
        currentStreak: Value(newStreak),
        longestStreak: Value(newStreak > stats.longestStreak ? newStreak : stats.longestStreak),
        lastWorkoutDate: Value(today),
      ));
    } else {
      // Gap in training. 
      if (stats.streakShields > 0) {
        // Use a shield!
        final remainingShields = stats.streakShields - 1;
        
        _notificationService.addEvent(StreakShieldExpendedEvent(
          remainingShields: remainingShields,
          currentStreak: stats.currentStreak + 1,
        ));

        await _dao.upsertUserStats(stats.toCompanion(false).copyWith(
          streakShields: Value(remainingShields),
          currentStreak: Value(stats.currentStreak + 1), // Shield keeps the streak going
          lastWorkoutDate: Value(today),
        ));
      } else {
        // Streak reset :(
        await _dao.upsertUserStats(stats.toCompanion(false).copyWith(
          currentStreak: const Value(1),
          lastWorkoutDate: Value(today),
        ));
      }
    }
  }

  /// Refills shields based on consistency (e.g., earn 1 shield every 7-day streak)
  Future<void> checkShieldReward(String userId) async {
    final stats = await _dao.getUserStats(userId);
    if (stats == null) return;

    if (stats.currentStreak > 0 && stats.currentStreak % 7 == 0) {
      // Earn a shield every 7 days, max 3
      if (stats.streakShields < 3) {
        await _dao.upsertUserStats(stats.toCompanion(false).copyWith(
          streakShields: Value(stats.streakShields + 1),
        ));
      }
    }
  }
}

