import 'package:fit/features/common/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/health_snapshot.dart';
import '../../domain/models/health_sync_result.dart';
import '../providers/health_providers.dart';

/// Compact banner displaying wearable health bio-signals.
///
/// Shows HRV, Resting HR, and Sleep Score as color-coded pills
/// with a sync status indicator. Designed for the coaching dashboard.
class HealthStatusBanner extends ConsumerWidget {
  const HealthStatusBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshotAsync = ref.watch(latestHealthSnapshotProvider);
    final syncAsync = ref.watch(healthSyncTriggerProvider);

    return snapshotAsync.when(
      loading: () => _buildShimmer(),
      error: (_, _) => const SizedBox.shrink(),
      data: (snapshot) {
        if (snapshot == null || !snapshot.hasSignal) {
          return _buildPermissionNudge(context, ref, syncAsync);
        }
        return _buildBanner(context, snapshot);
      },
    );
  }

  Widget _buildBanner(BuildContext context, HealthSnapshot snapshot) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FitColors.obsidian.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(FitRadii.card),
        border: Border.all(
          color: FitColors.cyberCyan.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Icon(
                Icons.monitor_heart_outlined,
                color: FitColors.cyberCyan,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Recovery Signals',
                style: TextStyle(
                  color: FitColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              // Stale data indicator
              if (snapshot.isStale)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'STALE',
                    style: TextStyle(
                      color: Colors.amber.shade300,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              // Source badge
              _SourceBadge(source: snapshot.syncSource),
            ],
          ),
          const SizedBox(height: 12),
          // Signal pills row
          Row(
            children: [
              if (snapshot.hrvMs != null)
                Expanded(
                  child: _SignalPill(
                    label: 'HRV',
                    value: '${snapshot.hrvMs!.toStringAsFixed(0)}ms',
                    color: _hrvColor(snapshot.hrvMs!),
                    icon: Icons.favorite_outline,
                  ),
                ),
              if (snapshot.restingHr != null) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: _SignalPill(
                    label: 'RHR',
                    value: '${snapshot.restingHr}bpm',
                    color: _rhrColor(snapshot.restingHr!),
                    icon: Icons.heart_broken_outlined,
                  ),
                ),
              ],
              if (snapshot.sleepScore != null) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: _SignalPill(
                    label: 'Sleep',
                    value:
                        '${(snapshot.sleepScore! * 100).toStringAsFixed(0)}%',
                    color: _sleepColor(snapshot.sleepScore!),
                    icon: Icons.bedtime_outlined,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionNudge(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<HealthSyncResult> syncAsync,
  ) {
    // Determine the message based on sync result
    String message = 'Connect a wearable for smarter recovery insights';
    bool showAction = true;

    syncAsync.whenData((result) {
      switch (result) {
        case HealthSyncPermissionDenied():
          message = 'Health access denied — tap to enable in Settings';
        case HealthSyncUnavailable():
          message = 'Enter recovery data manually for smarter coaching';
        case HealthSyncError():
          message = 'Sync error — tap to retry';
        case HealthSyncSuccess():
          showAction = false;
      }
    });

    if (!showAction) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: FitColors.obsidian.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(FitRadii.card),
        border: Border.all(
          color: FitColors.cyberCyan.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.watch_outlined,
            color: FitColors.cyberCyan.withValues(alpha: 0.6),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: FitColors.textSecondary, fontSize: 12),
            ),
          ),
          Icon(Icons.chevron_right, color: FitColors.textSecondary, size: 18),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 88,
      decoration: BoxDecoration(
        color: FitColors.obsidian.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(FitRadii.card),
      ),
    );
  }

  // ═══ Color mapping helpers ═══

  Color _hrvColor(double hrv) {
    if (hrv >= 60) return Colors.green.shade400;
    if (hrv >= 30) return Colors.amber.shade400;
    return Colors.red.shade400;
  }

  Color _rhrColor(int rhr) {
    if (rhr <= 60) return Colors.green.shade400;
    if (rhr <= 75) return Colors.amber.shade400;
    return Colors.red.shade400;
  }

  Color _sleepColor(double score) {
    if (score >= 0.75) return Colors.green.shade400;
    if (score >= 0.5) return Colors.amber.shade400;
    return Colors.red.shade400;
  }
}

/// A single bio-signal pill showing label, value, and status color.
class _SignalPill extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _SignalPill({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: FitColors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Badge indicating the data source (Apple / Google / Manual).
class _SourceBadge extends StatelessWidget {
  final HealthSyncSource source;

  const _SourceBadge({required this.source});

  @override
  Widget build(BuildContext context) {
    final (String label, IconData icon) = switch (source) {
      HealthSyncSource.apple => ('Apple', Icons.apple),
      HealthSyncSource.google => ('Google', Icons.health_and_safety_outlined),
      HealthSyncSource.manual => ('Manual', Icons.edit_note),
    };

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: FitColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: FitColors.textSecondary, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
