import 'package:fit/features/common/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../workout/presentation/widgets/glassmorphic_sheet.dart';
import '../../data/repository/manual_health_repository.dart';
import '../providers/health_providers.dart';

/// Bottom sheet for manual health data entry.
///
/// Used on desktop (dev mode) and as an alternative for users
/// who decline wearable permissions. Reuses the [GlassmorphicSheet]
/// scaffold and stepper pattern from P0.
class HealthManualEntrySheet extends ConsumerStatefulWidget {
  const HealthManualEntrySheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const HealthManualEntrySheet(),
    );
  }

  @override
  ConsumerState<HealthManualEntrySheet> createState() =>
      _HealthManualEntrySheetState();
}

class _HealthManualEntrySheetState
    extends ConsumerState<HealthManualEntrySheet> {
  double _hrvMs = 55.0;
  int _restingHr = 60;
  double _sleepScore = 0.75;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicSheet(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: FitColors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Row(
              children: [
                Icon(Icons.edit_note, color: FitColors.cyberCyan, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Manual Recovery Entry',
                  style: TextStyle(
                    color: FitColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // HRV Stepper
            _StepperRow(
              label: 'HRV (ms)',
              value: _hrvMs.toStringAsFixed(0),
              subtitle: _hrvMs < 30
                  ? 'Low — Fatigued'
                  : (_hrvMs > 60 ? 'Good — Recovered' : 'Moderate'),
              color: _hrvMs < 30
                  ? Colors.red.shade400
                  : (_hrvMs > 60
                        ? Colors.green.shade400
                        : Colors.amber.shade400),
              onDecrement: () {
                HapticFeedback.lightImpact();
                setState(() => _hrvMs = (_hrvMs - 5).clamp(10.0, 120.0));
              },
              onIncrement: () {
                HapticFeedback.lightImpact();
                setState(() => _hrvMs = (_hrvMs + 5).clamp(10.0, 120.0));
              },
            ),
            const SizedBox(height: 16),

            // Resting HR Stepper
            _StepperRow(
              label: 'Resting HR (bpm)',
              value: '$_restingHr',
              subtitle: _restingHr > 75
                  ? 'Elevated — Fatigued'
                  : (_restingHr < 60 ? 'Good — Recovered' : 'Normal'),
              color: _restingHr > 75
                  ? Colors.red.shade400
                  : (_restingHr < 60
                        ? Colors.green.shade400
                        : Colors.amber.shade400),
              onDecrement: () {
                HapticFeedback.lightImpact();
                setState(() => _restingHr = (_restingHr - 1).clamp(35, 120));
              },
              onIncrement: () {
                HapticFeedback.lightImpact();
                setState(() => _restingHr = (_restingHr + 1).clamp(35, 120));
              },
            ),
            const SizedBox(height: 16),

            // Sleep Quality Stepper
            _StepperRow(
              label: 'Sleep Quality',
              value: '${(_sleepScore * 100).toStringAsFixed(0)}%',
              subtitle: _sleepScore < 0.5
                  ? 'Poor'
                  : (_sleepScore > 0.75 ? 'Excellent' : 'Fair'),
              color: _sleepScore < 0.5
                  ? Colors.red.shade400
                  : (_sleepScore > 0.75
                        ? Colors.green.shade400
                        : Colors.amber.shade400),
              onDecrement: () {
                HapticFeedback.lightImpact();
                setState(
                  () => _sleepScore = (_sleepScore - 0.05).clamp(0.0, 1.0),
                );
              },
              onIncrement: () {
                HapticFeedback.lightImpact();
                setState(
                  () => _sleepScore = (_sleepScore + 0.05).clamp(0.0, 1.0),
                );
              },
            ),
            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: FitColors.cyberCyan,
                  foregroundColor: FitColors.obsidian,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      )
                    : const Text(
                        'SAVE RECOVERY DATA',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    HapticFeedback.mediumImpact();

    try {
      final repo = ref.read(healthSyncRepositoryProvider);
      if (repo is ManualHealthRepository) {
        await repo.saveManualEntry(
          userId: 'local-user',
          hrvMs: _hrvMs,
          restingHr: _restingHr,
          sleepScore: _sleepScore,
        );
      }
      // Invalidate to refresh the banner
      ref.invalidate(latestHealthSnapshotProvider);
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

/// Reusable stepper row with label, value, and +/- buttons.
class _StepperRow extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final Color color;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _StepperRow({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.color,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: FitColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        _StepperButton(icon: Icons.remove, onPressed: onDecrement),
        Container(
          width: 56,
          alignment: Alignment.center,
          child: Text(
            value,
            style: TextStyle(
              color: FitColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
        _StepperButton(icon: Icons.add, onPressed: onIncrement),
      ],
    );
  }
}

/// Circular +/- stepper button with light haptic feedback.
class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _StepperButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: FitColors.cyberCyan.withValues(alpha: 0.1),
            border: Border.all(
              color: FitColors.cyberCyan.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Icon(icon, color: FitColors.cyberCyan, size: 18),
        ),
      ),
    );
  }
}
