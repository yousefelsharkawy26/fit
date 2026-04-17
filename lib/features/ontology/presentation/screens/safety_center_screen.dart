import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import '../../data/database/database.dart';
import '../../domain/enums/ontology_enums.dart';
import '../../domain/models/ontology_models.dart';
import '../providers/ontology_data_providers.dart';


/// The Safety Center / Injury Command Center.
/// Allows users to register hardware failures (injuries) or degradation (soreness).
/// Integrates with the "Kinetic Lens" design system.
class SafetyCenterScreen extends ConsumerWidget {
  const SafetyCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muscleRegionsAsync = ref.watch(allMuscleRegionsProvider);
    final constraintsAsync = ref.watch(activeMuscleConstraintsProvider);
    final userId = ref.watch(currentUserIdProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Obsidian
      appBar: AppBar(
        title: const Text(
          'SAFETY RADIUS',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: muscleRegionsAsync.when(
        data: (muscles) => constraintsAsync.when(
          data: (constraints) => _buildBody(context, ref, userId, muscles, constraints),
          loading: () => const Center(child: CircularProgressIndicator(color: Colors.cyan)),
          error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.redAccent))),
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.cyan)),
        error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.redAccent))),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    String userId,
    List<MuscleRegion> allMuscles,
    List<MuscleConstraint> constraints,
  ) {
    // Group muscles by their muscle group
    final Map<String, List<MuscleRegion>> groupedMuscles = {};
    for (final m in allMuscles) {
      groupedMuscles.putIfAbsent(m.muscleGroup, () => []).add(m);
    }

    final activeInjuries = constraints.where((c) => c.status == MuscleConstraintStatus.injured).length;
    final activeSoreness = constraints.where((c) => c.status == MuscleConstraintStatus.sore).length;

    return Column(
      children: [
        _buildStatusBar(activeInjuries, activeSoreness),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: groupedMuscles.keys.length,
            itemBuilder: (context, index) {
              final groupName = groupedMuscles.keys.elementAt(index);
              final groupMuscles = groupedMuscles[groupName]!;
              return _buildRegionSection(context, ref, userId, groupName, groupMuscles, constraints);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBar(int injured, int sore) {
    if (injured == 0 && sore == 0) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.5)),
        ),
        child: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.blueAccent),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'ALL SYSTEMS NOMINAL\nReady for unrestricted physical load.',
                style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: injured > 0 
          ? Colors.redAccent.withValues(alpha: 0.1)
          : Colors.orangeAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: injured > 0 ? Colors.redAccent.withValues(alpha: 0.5) : Colors.orangeAccent.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(
             injured > 0 ? Icons.warning_amber_rounded : Icons.shield_outlined,
             color: injured > 0 ? Colors.redAccent : Colors.orangeAccent,
             size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  injured > 0 ? 'RESTRICTIONS ACTIVE' : 'PERFORMANCE LIMITERS LOGGED',
                  style: TextStyle(
                    color: injured > 0 ? Colors.redAccent : Colors.orangeAccent,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Constraints initialized: $injured Injuries, $sore Sore Areas',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionSection(
    BuildContext context,
    WidgetRef ref,
    String userId,
    String regionName,
    List<MuscleRegion> muscles,
    List<MuscleConstraint> constraints,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            regionName.toUpperCase(),
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: muscles.map((muscle) {
            final constraint = constraints.firstWhere(
              (c) => c.muscleId == muscle.id,
              orElse: () => const MuscleConstraint(
                muscleId: '',
                status: MuscleConstraintStatus.target, // Fallback for healthy
              ),
            );

            final isInjured = constraint.muscleId == muscle.id && constraint.status == MuscleConstraintStatus.injured;
            final isSore = constraint.muscleId == muscle.id && constraint.status == MuscleConstraintStatus.sore;

            return _InteractiveKineticChip(
              name: muscle.name,
              isInjured: isInjured,
              isSore: isSore,
              onTap: () {
                // Tactical Haptic Feedback Layer
                HapticFeedback.heavyImpact();
                
                MuscleConstraintStatus? nextStatus;
                if (!isInjured && !isSore) {
                  nextStatus = MuscleConstraintStatus.sore; // Healthy -> Sore
                } else if (isSore) {
                  nextStatus = MuscleConstraintStatus.injured; // Sore -> Injured
                } else {
                  nextStatus = null; // Injured -> Healthy
                }
                
                _updateConstraint(ref, userId, muscle.id, nextStatus);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Future<void> _updateConstraint(
    WidgetRef ref,
    String userId,
    String muscleId,
    MuscleConstraintStatus? status,
  ) async {
    final dao = ref.read(exerciseDaoProvider);
    if (status == null) {
      await dao.removeMuscleConstraint(userId, muscleId);
    } else {
      await dao.saveMuscleConstraint(
        UserMuscleConstraintsCompanion.insert(
          userId: userId,
          muscleId: muscleId,
          status: status,
          expiresAt: const drift.Value(null),
        ),
      );
    }
    // Note: the constraint provider is a StreamProvider so it will react automatically
    // But we still invalidate the substitution engine just to make sure
    ref.invalidate(substitutionResultsProvider);
  }
}

class _InteractiveKineticChip extends StatelessWidget {
  final String name;
  final bool isInjured;
  final bool isSore;
  final VoidCallback onTap;

  const _InteractiveKineticChip({
    required this.name,
    required this.isInjured,
    required this.isSore,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color baseColor = Colors.white24;
    Color borderColor = Colors.transparent;
    Color textColor = Colors.white;

    if (isSore) {
      baseColor = Colors.orangeAccent.withValues(alpha: 0.15);
      borderColor = Colors.orangeAccent.withValues(alpha: 0.5);
      textColor = Colors.orangeAccent;
    } else if (isInjured) {
      baseColor = Colors.redAccent.withValues(alpha: 0.2);
      borderColor = Colors.redAccent;
      textColor = Colors.redAccent;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: isInjured ? Colors.white24 : Colors.redAccent.withValues(alpha: 0.3),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isInjured)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.block, size: 14, color: Colors.redAccent),
                )
              else if (isSore)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.warning, size: 14, color: Colors.orangeAccent),
                ),
              Text(
                name,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
