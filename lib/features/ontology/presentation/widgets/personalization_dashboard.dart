import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/database.dart';
import '../../domain/enums/ontology_enums.dart';
import '../../domain/models/ontology_models.dart';
import '../providers/ontology_data_providers.dart';


/// One-stop shop for "Safety and Preferences".
///
/// Allows users to:
/// 1. Mark muscles as Sore or Injured (Contextual Constraints).
/// 2. Manage exercise favorites/dislikes (Bias Layer).
class PersonalizationDashboard extends ConsumerWidget {
  const PersonalizationDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final muscleRegions = ref.watch(allMuscleRegionsProvider);
    final constraints = ref.watch(activeMuscleConstraintsProvider);
    final userId = ref.watch(currentUserIdProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              _buildHeader(context, theme),
              const Divider(height: 1),

              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    _SectionHeader(
                      'Injury & Soreness Tracking',
                      Icons.health_and_safety_outlined,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select muscles that are currently painful or restricted. '
                      'Injured muscles will trigger an immediate hard-stop filter on exercises.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 20),

                    muscleRegions.when(
                      data: (list) => constraints.when(
                        data: (active) => _MuscleGrid(
                          allMuscles: list,
                          activeConstraints: active,
                          onToggle: (muscleId, status) =>
                              _updateConstraint(ref, userId, muscleId, status),
                        ),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Text('Error: $e'),
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Text('Error: $e'),
                    ),

                    const SizedBox(height: 40),
                    _SectionHeader(
                      'Exercise Bias Layer',
                      Icons.favorite_border,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your favorites are boosted in substitution logic, '
                      'while disliked exercises are penalized but not hidden.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPreferencesList(ref),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Safety & Preferences',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Personalize your ontology',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          IconButton.filledTonal(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesList(WidgetRef ref) {
    final prefs = ref.watch(userPreferencesProvider);
    return prefs.when(
      data: (list) {
        if (list.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'No custom preferences set yet. Long-press an exercise in the substitution list to favorite.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
            ),
          );
        }
        return Column(
          children: list
              .map(
                (p) => ListTile(
                  title: Text(
                    'Exercise ID: ${p.exerciseId}',
                  ), // In real app, resolved exercise name
                  trailing: Icon(
                    p.preferenceScore > 1.0 ? Icons.favorite : Icons.thumb_down,
                    color: p.preferenceScore > 1.0 ? Colors.red : Colors.grey,
                  ),
                ),
              )
              .toList(),
        );
      },
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('Error loading preferences: $e'),
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
          expiresAt: const Value(
            null,
          ), // For smoke test, permanent until cleared
        ),
      );
    }
    ref.invalidate(activeMuscleConstraintsProvider);
    // Also invalidate substitution results because the filter changed!
    ref.invalidate(substitutionResultsProvider);
  }
}

class _MuscleGrid extends StatelessWidget {
  final List<MuscleRegion> allMuscles;
  final List<MuscleConstraint> activeConstraints;
  final Function(String muscleId, MuscleConstraintStatus? status) onToggle;

  const _MuscleGrid({
    required this.allMuscles,
    required this.activeConstraints,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: allMuscles.map((muscle) {
        final constraint = activeConstraints.firstWhere(
          (c) => c.muscleId == muscle.id,
          orElse: () => const MuscleConstraint(
            muscleId: '',
            status: MuscleConstraintStatus.target,
          ),
        );

        final isActive = constraint.muscleId == muscle.id;
        final isInjured =
            isActive && constraint.status == MuscleConstraintStatus.injured;
        final isSore =
            isActive && constraint.status == MuscleConstraintStatus.sore;

        return ChoiceChip(
          label: Text(muscle.name),
          selected: isActive,
          selectedColor: isInjured
              ? Colors.red.withValues(alpha: 0.2)
              : Colors.orange.withValues(alpha: 0.2),
          avatar: isActive
              ? Icon(
                  isInjured ? Icons.cancel : Icons.warning_amber,
                  size: 14,
                  color: isInjured ? Colors.red : Colors.orange,
                )
              : null,
          onSelected: (_) {
            // Cycle: Healthy -> Sore -> Injured -> Healthy
            if (!isActive) {
              onToggle(muscle.id, MuscleConstraintStatus.sore);
            } else if (isSore) {
              onToggle(muscle.id, MuscleConstraintStatus.injured);
            } else {
              onToggle(muscle.id, null);
            }
          },
        );
      }).toList(),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}
