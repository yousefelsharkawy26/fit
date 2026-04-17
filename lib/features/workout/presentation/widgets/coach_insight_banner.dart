/// coach_insight_banner.dart
///
/// Extracted AI Coach insight banner with [AnimatedSwitcher] transitions.
/// Displays real-time coaching recommendations during an active workout.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit/features/common/design_tokens.dart';
import 'package:fit/features/coaching/presentation/providers/coaching_providers.dart';
import 'package:fit/features/coaching/domain/services/coach_reasoning_engine.dart';

class CoachInsightBanner extends ConsumerWidget {
  const CoachInsightBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightAsync = ref.watch(coachInsightProvider);

    return insightAsync.when(
      data: (response) => _InsightContent(response: response),
      loading: () => const LinearProgressIndicator(
        color: FitColors.cyberCyan,
        backgroundColor: Colors.transparent,
      ),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _InsightContent extends StatelessWidget {
  final CoachResponse response;

  const _InsightContent({required this.response});

  @override
  Widget build(BuildContext context) {
    final message = switch (response) {
      CoachRecommendation r => r.suggestion,
      CoachAlert a => '⚠️ ${a.title}: ${a.message}',
      CoachSplitChange s => 'New Split: ${s.newSplitName}',
    };

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: FitColors.cardFill,
          borderRadius: BorderRadius.circular(FitRadii.card),
          border: Border.all(color: FitColors.cardBorder),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.psychology_outlined,
              color: FitColors.cyberCyan,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI COACH STRATEGY',
                    style: TextStyle(
                      color: FitColors.cyberCyan,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: FitDurations.normal,
                    switchInCurve: FitCurves.enter,
                    switchOutCurve: FitCurves.exit,
                    child: Text(
                      message,
                      key: ValueKey(message),
                      style: const TextStyle(
                        color: FitColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
