import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/gamification_notification_service.dart';
import '../../domain/models/gamification_events.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';

class GamificationOverlayListener extends ConsumerWidget {
  final Widget child;

  const GamificationOverlayListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<List<GamificationEvent>>(
      gamificationNotificationProvider,
      (previous, next) {
        if (next.isNotEmpty) {
          final event = next.first;
          _showGamificationOverlay(context, ref, event);
        }
      },
    );

    return child;
  }

  void _showGamificationOverlay(BuildContext context, WidgetRef ref, GamificationEvent event) {
    // Pop the event so it isn't shown again
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gamificationNotificationProvider.notifier).popEvent();
    });

    if (event is PrAchievementEvent) {
      HapticFeedback.mediumImpact();
      _showPrDialog(context, event);
    } else if (event is MuscleLevelUpEvent) {
      HapticFeedback.heavyImpact();
      _showMuscleLevelUpDialog(context, event);
    } else if (event is StreakShieldExpendedEvent) {
      HapticFeedback.vibrate();
      _showShieldUsedDialog(context, event);
    } else if (event is StreakMilestoneEvent) {
      HapticFeedback.mediumImpact();
      _showStreakMilestoneDialog(context, event);
    }
  }

  void _showPrDialog(BuildContext context, PrAchievementEvent event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 150,
                child: Lottie.network(
                  'https://lottie.host/82df092b-87cf-45d2-a720-3051fb84f67c/WLY78sQ31h.json', // Confetti
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.fitness_center, size: 64, color: Colors.amber),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'NEW PR!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${event.exerciseName}\\n${event.weight}kg x ${event.reps}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMuscleLevelUpDialog(BuildContext context, MuscleLevelUpEvent event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Muscle Level Up!', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 120,
                child: Lottie.network(
                  'https://lottie.host/83e8faac-5be8-4660-bb46-e52fdcc2884c/x1AILPq8uU.json', // Level Up / Trophy
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.arrow_upward, size: 64, color: Colors.green),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your ${event.muscleRegionId} has reached Level ${event.newLevel}!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('AWESOME'),
            ),
          ],
        );
      },
    );
  }

  void _showShieldUsedDialog(BuildContext context, StreakShieldExpendedEvent event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Streak Saved!', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 120,
                child: Lottie.network(
                  'https://lottie.host/4a49c9f7-6c2e-4b47-b8d1-1ce32b0f2a96/Ld3yQpI9N1.json', // Shield 
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.shield, size: 64, color: Colors.blueAccent),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'You missed a day, but your Streak Shield activated!\\n\\nCurrent Streak: ${event.currentStreak}\\nShields Remaining: ${event.remainingShields}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('PHEW!'),
            ),
          ],
        );
      },
    );
  }

  void _showStreakMilestoneDialog(BuildContext context, StreakMilestoneEvent event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Streak Milestone!', textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 120,
                child: Lottie.network(
                  'https://lottie.host/be8eeeb1-f09b-466d-ae9a-5b1b44b8ee59/jVf2s0S5C1.json', // Fire / Flame
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.local_fire_department, size: 64, color: Colors.orange),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'You hit a ${event.streakDays}-day streak! Keep the momentum going.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('LFG'),
            ),
          ],
        );
      },
    );
  }
}
