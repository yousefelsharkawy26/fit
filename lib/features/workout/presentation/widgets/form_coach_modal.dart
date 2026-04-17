import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:fit/features/common/design_tokens.dart';
import 'package:fit/features/ontology/domain/models/ontology_models.dart';
import 'glassmorphic_sheet.dart';

class FormCoachModal extends StatelessWidget {
  final Exercise exercise;

  const FormCoachModal({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    // If the exercise has a specific lottie definition, use it. Otherwise, use placeholder.
    final hasLottie =
        exercise.lottieUrl != null && exercise.lottieUrl!.isNotEmpty;
    final lottiePath = hasLottie
        ? exercise.lottieUrl!
        : 'assets/lottie/placeholders/default_wireframe.json';

    return GlassmorphicSheet(
      maxHeightFraction: 0.75, // Cover 75% of the screen
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Form Coach: ${exercise.name}',
                  style: const TextStyle(
                    color: FitColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close_rounded, color: FitColors.textSecondary),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Lottie Animation Container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: FitColors.cardFill.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(FitRadii.card),
                border: Border.all(color: FitColors.cardBorder),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(FitRadii.card),
                child: Lottie.asset(
                  lottiePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.broken_image_rounded,
                        color: Colors.white60,
                        size: 48,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Instructions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FitColors.cardFill.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(FitRadii.card),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.smart_toy_rounded,
                      color: FitColors.cyberCyan,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'AI Coach Notes',
                      style: TextStyle(
                        color: FitColors.cyberCyan,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  (exercise.instructions != null &&
                          exercise.instructions!.isNotEmpty)
                      ? exercise.instructions!
                      : 'Maintain a neutral spine and controlled breathing. Focus on mind-muscle connection with the ${exercise.primaryMuscleId}.',
                  style: TextStyle(
                    color: FitColors.textSecondary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
