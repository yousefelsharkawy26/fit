import 'package:flutter/material.dart';

import '../../domain/models/ontology_models.dart';

/// The "Why this suggestion?" visualizer.
/// 
/// Shows the human-readable explanation of why the vector algorithm
/// selected this specific substitution by comparing dimensions.
class SubstitutionExplanation extends StatelessWidget {
  final SubstitutionResult result;
  final Exercise source;

  const SubstitutionExplanation({
    super.key,
    required this.result,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    final alt = result.exercise;
    
    // Calculate matching dimensions visually
    final muscleMatch = alt.primaryMuscles.map((m) => m.muscle.id).toSet()
        .containsAll(source.primaryMuscles.map((m) => m.muscle.id).toSet());
        
    final patternMatch = alt.movementPattern == source.movementPattern;
    final equipmentMatch = alt.equipment.id == source.equipment.id;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Explainability Score: ${result.similarityPercent.toStringAsFixed(1)}%',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 8),
          _buildMatchRow(
            context,
            isMatch: muscleMatch,
            text: muscleMatch ? 'Hits identical primary muscles' : 'Different primary muscle emphasis',
          ),
          _buildMatchRow(
            context,
            isMatch: patternMatch,
            text: patternMatch ? 'Matches movement pattern' : 'Different movement pattern',
            weightText: 'x2.5 weight',
          ),
          _buildMatchRow(
            context,
            isMatch: equipmentMatch,
            text: equipmentMatch ? 'Same equipment class' : 'Different equipment class',
            weightText: 'x2.0 weight',
          ),
          
          if (result.constraintsRelaxed) ...[
            const Divider(),
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, size: 14, color: Colors.orange),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Constraints relaxed: ${result.relaxedConstraints.join(", ")}',
                    style: const TextStyle(fontSize: 11, color: Colors.orange),
                  ),
                ),
              ],
            ),
          ],
          
          if (result.personalizationNote != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                   Icon(Icons.auto_awesome, size: 12, color: Theme.of(context).colorScheme.primary),
                   const SizedBox(width: 6),
                   Expanded(
                     child: Text(
                       result.personalizationNote!,
                       style: TextStyle(
                         fontSize: 11, 
                         color: Theme.of(context).colorScheme.primary,
                         fontStyle: FontStyle.italic,
                       ),
                     ),
                   ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMatchRow(BuildContext context, {required bool isMatch, required String text, String? weightText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            isMatch ? Icons.check_circle : Icons.info_outline,
            size: 14,
            color: isMatch ? Colors.green : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 12)),
          if (weightText != null) ...[
            const Spacer(),
            Text(weightText, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ],
      ),
    );
  }
}
