import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums/ontology_enums.dart';
import '../../domain/models/ontology_models.dart';
import '../providers/substitution_providers.dart';

/// Interactive UI chip bar allowing users to toggle hard constraints.
/// Example: "Exclude Barbells" or "Must be Unilateral".
///
/// See: exercise_ontology_design.md §5.3.1 — Constraint Filters
class ConstraintChips extends ConsumerWidget {
  const ConstraintChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final constraints = ref.watch(substitutionConstraintsProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // Exclude Equipment (Quick Filters for common "Bottlenecks")
          ...[
            {'id': 'eq-001-barbell', 'label': 'No Barbell'},
            {'id': 'eq-002-dumbbell', 'label': 'No Dumbbell'},
            {'id': 'eq-003-cable', 'label': 'No Cable'},
            {'id': 'eq-004-machine', 'label': 'No Machine'},
          ].map((eq) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _buildActionChip(
              context,
              label: eq['label']!,
              isActive: constraints.excludeEquipmentIds?.contains(eq['id']!) ?? false,
              onTap: () {
                final notifier = ref.read(substitutionConstraintsProvider.notifier);
                final current = notifier.state;
                final ids = List<String>.from(current.excludeEquipmentIds ?? []);
                if (ids.contains(eq['id'])) {
                  ids.remove(eq['id']);
                } else {
                  ids.add(eq['id']!);
                }
                notifier.state = current.copyWith(excludeEquipmentIds: ids);
              },
            ),
          )),

          // Require Unilateral (Quick Filter for injuries/imbalances)
          _buildActionChip(
            context,
            label: 'Unilateral Only',
            isActive: constraints.requireLaterality == Laterality.unilateral,
            onTap: () {
              final newLaterality =
                  constraints.requireLaterality == Laterality.unilateral
                      ? null
                      : Laterality.unilateral;
              
              ref.read(substitutionConstraintsProvider.notifier).state =
                  SubstitutionConstraints(
                    excludeEquipmentIds: constraints.excludeEquipmentIds,
                    requireLaterality: newLaterality,
                    excludeLoadingType: constraints.excludeLoadingType,
                    maxSkillLevel: constraints.maxSkillLevel,
                    excludeExerciseIds: constraints.excludeExerciseIds,
                  );
            },
          ),
          const SizedBox(width: 8),

          // Exclude Axial Loading (Quick Filter for back pain safety)
          _buildActionChip(
            context,
            label: 'Back Safe (No Axial)',
            isActive: constraints.excludeLoadingType == LoadingType.axial,
            onTap: () {
              final newLoading =
                  constraints.excludeLoadingType == LoadingType.axial
                      ? null
                      : LoadingType.axial;
              
              ref.read(substitutionConstraintsProvider.notifier).state =
                  SubstitutionConstraints(
                    excludeEquipmentIds: constraints.excludeEquipmentIds,
                    requireLaterality: constraints.requireLaterality,
                    excludeLoadingType: newLoading,
                    maxSkillLevel: constraints.maxSkillLevel,
                    excludeExerciseIds: constraints.excludeExerciseIds,
                  );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(
    BuildContext context, {
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return ActionChip(
      label: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Theme.of(context).colorScheme.onSurface,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      backgroundColor: isActive ? Theme.of(context).colorScheme.primary : null,
      onPressed: onTap,
    );
  }
}
