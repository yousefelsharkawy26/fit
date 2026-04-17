import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fit/features/common/design_tokens.dart';
import '../../../coaching/presentation/providers/predictive_providers.dart';

class PredictivePrescriptionCard extends ConsumerWidget {
  final String exerciseId;

  const PredictivePrescriptionCard({super.key, required this.exerciseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPrescription = ref.watch(
      exercisePrescriptionProvider(exerciseId),
    );

    return asyncPrescription.when(
      data: (prescription) {
        if (prescription.isDiscovery) {
          return _buildCard(
            context: context,
            title: 'Discovery Set',
            subtitle: prescription.rationaleNote,
            target:
                '${prescription.targetReps} Reps @ RPE ${prescription.targetRpe}',
            accentColor: StyleSeedColors.accentCyan,
          );
        }

        return _buildCard(
          context: context,
          title: 'Target Prescription',
          subtitle: prescription.rationaleNote,
          target:
              '${prescription.targetWeight} kg x ${prescription.targetReps} reps',
          accentColor: StyleSeedColors.accentViolet,
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String target,
    required Color accentColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: StyleSeedColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome, color: accentColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  target,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: StyleSeedColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: StyleSeedColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
