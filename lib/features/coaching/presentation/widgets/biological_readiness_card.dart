import 'package:fit/features/coaching/domain/models/recovery_readiness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/recovery_readiness_provider.dart';

class BiologicalReadinessCard extends ConsumerWidget {
  const BiologicalReadinessCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readinessAsync = ref.watch(recoveryReadinessProvider);

    return readinessAsync.when(
      data: (readiness) => _buildCard(context, readiness),
      loading: () => _buildLoading(),
      error: (err, _) => _buildError(err.toString()),
    );
  }

  Widget _buildCard(BuildContext context, RecoveryReadiness readiness) {
    final color = _getStatusColor(readiness.level);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(readiness, color),
          const SizedBox(height: 16),
          _buildBatteryIndicator(readiness.score, color),
          const SizedBox(height: 16),
          Text(
            readiness.recommendation,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.4,
              fontFamily: 'SpaceGrotesk',
            ),
          ),
          const SizedBox(height: 16),
          _buildFactorTags(readiness.factorContributions),
        ],
      ),
    );
  }

  Widget _buildHeader(RecoveryReadiness readiness, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BIOLOGICAL READINESS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontFamily: 'SpaceGrotesk',
              ),
            ),
            Text(
              readiness.level.name.toUpperCase(),
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
                fontFamily: 'SpaceGrotesk',
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Text(
            '${readiness.score.round()}%',
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              fontFamily: 'SpaceGrotesk',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBatteryIndicator(double score, Color color) {
    return Container(
      height: 12,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOutCubic,
            width: (score / 100) * 400, // Normalized Width in stack
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.5), color],
              ),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFactorTags(Map<String, double> factors) {
    return Wrap(
      spacing: 8,
      children: factors.entries.map((entry) {
        final label = entry.key.toUpperCase();
        final score = (entry.value * 100).round();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$label: $score',
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLoading() {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.cyanAccent),
      ),
    );
  }

  Widget _buildError(String error) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        'Readiness Offline: $error',
        style: const TextStyle(color: Colors.redAccent, fontSize: 12),
      ),
    );
  }

  Color _getStatusColor(RecoveryLevel level) {
    switch (level) {
      case RecoveryLevel.optimal:
        return const Color(0xFF22C55E); // Green
      case RecoveryLevel.recovered:
        return const Color(0xFF34D399); // Emerald
      case RecoveryLevel.restoring:
        return const Color(0xFFEAB308); // Yellow
      case RecoveryLevel.fatigued:
        return const Color(0xFFF97316); // Orange
      case RecoveryLevel.danger:
        return const Color(0xFFEF4444); // Red
    }
  }
}
