/// session_stats_bar.dart
///
/// Extracted workout session stats bar showing exercise count, logged sets,
/// and active status indicator. Uses [TweenAnimationBuilder] for smooth
/// numeric transitions.
library;

import 'package:flutter/material.dart';
import 'package:fit/features/common/design_tokens.dart';

class SessionStatsBar extends StatelessWidget {
  final int exerciseCount;
  final int loggedSets;

  const SessionStatsBar({
    super.key,
    required this.exerciseCount,
    required this.loggedSets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: FitColors.cardFill,
          borderRadius: BorderRadius.circular(FitRadii.card),
          border: Border.all(color: FitColors.cardBorder),
        ),
        child: Row(
          children: [
            _AnimatedMiniStat(
              icon: Icons.fitness_center,
              label: 'Exercises',
              value: exerciseCount,
            ),
            const SizedBox(width: 12),
            _AnimatedMiniStat(
              icon: Icons.playlist_add_check_circle_outlined,
              label: 'Logged Sets',
              value: loggedSets,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: FitColors.cyberCyanMuted,
                borderRadius: BorderRadius.circular(FitRadii.pill),
              ),
              child: const Text(
                'ACTIVE',
                style: TextStyle(
                  color: FitColors.cyberCyan,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedMiniStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;

  const _AnimatedMiniStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: FitColors.textSecondary),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TweenAnimationBuilder<int>(
              tween: IntTween(begin: 0, end: value),
              duration: FitDurations.normal,
              curve: FitCurves.standard,
              builder: (context, animatedValue, _) => Text(
                '$animatedValue',
                style: const TextStyle(
                  color: FitColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              label,
              style: TextStyle(color: FitColors.textSecondary, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
