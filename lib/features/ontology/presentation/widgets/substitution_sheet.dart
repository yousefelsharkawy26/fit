import 'dart:ui';
import 'package:fit/features/ontology/domain/enums/ontology_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/sync/flywheel_client.dart';
import '../../domain/models/ontology_models.dart';
import '../../domain/services/flywheel_sync_service.dart';
import '../providers/substitution_providers.dart';
import '../providers/ontology_data_providers.dart';
import 'constraint_chips.dart';
import 'substitution_explanation.dart';
import 'add_custom_exercise_sheet.dart';
import 'personalization_dashboard.dart';

/// The core "Gym Mode" substitution interface.
class SubstitutionSheet extends ConsumerStatefulWidget {
  final String sourceExerciseId;
  final Function(Exercise) onExerciseSelected;

  const SubstitutionSheet({
    super.key,
    required this.sourceExerciseId,
    required this.onExerciseSelected,
  });

  @override
  ConsumerState<SubstitutionSheet> createState() => _SubstitutionSheetState();

  /// Helper to launch the bottom sheet
  static Future<void> show(
    BuildContext context,
    String sourceExerciseId, {
    required Function(Exercise) onExerciseSelected,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor:
          Colors.transparent, // Required for the glass effect above
      builder: (context) => SubstitutionSheet(
        sourceExerciseId: sourceExerciseId,
        onExerciseSelected: onExerciseSelected,
      ),
    );
  }
}

class _SubstitutionSheetState extends ConsumerState<SubstitutionSheet> {
  String? _expandedExplanationId;

  @override
  Widget build(BuildContext context) {
    final sourceExerciseAsync = ref.watch(
      exerciseDetailProvider(widget.sourceExerciseId),
    );
    final resultsAsync = ref.watch(
      substitutionResultsProvider(widget.sourceExerciseId),
    );

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A).withValues(alpha: 0.85),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Handle
                const SizedBox(height: 12),
                Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),

                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      const Text(
                        'Swap Exercise',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.shield_outlined,
                          color: Colors.cyanAccent,
                        ),
                        tooltip: 'Safety & Preferences',
                        onPressed: () => _showPersonalizationDashboard(context),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white54,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // Source exercise context
                sourceExerciseAsync.when(
                  data: (source) => source != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 8.0,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Finding alternatives for ${source.name}',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),

                const SizedBox(height: 16),

                // Active Filters / Constraints (Equipment-First Bottleneck Gate)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.tune_rounded, size: 16, color: Colors.cyanAccent),
                      const SizedBox(width: 8),
                      const Text(
                        'EQUIPMENT BOTTLENECK GATE',
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Spacer(),
                      Tooltip(
                        message: 'These constraints strictly filter the AI vector search.',
                        child: Icon(Icons.info_outline_rounded, size: 14, color: Colors.white.withValues(alpha: 0.3)),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ConstraintChips(),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Divider(
                    color: Colors.white.withValues(alpha: 0.1),
                    height: 1,
                  ),
                ),

                // Ranked Results
                Expanded(
                  child: resultsAsync.when(
                    data: (results) {
                      if (results.isEmpty) {
                        return _EmptyState(
                          onAddCustom: () => _showAddCustomExercise(context),
                        );
                      }

                      final source = sourceExerciseAsync.value;
                      if (source == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.cyanAccent,
                          ),
                        );
                      }

                      return ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: results.length + 1,
                        itemBuilder: (context, index) {
                          if (index == results.length) {
                            return _FooterCTA(
                              onAddCustom: () =>
                                  _showAddCustomExercise(context),
                            );
                          }
                          return _ResultTile(
                            result: results[index],
                            source: source,
                            isExpanded:
                                _expandedExplanationId ==
                                results[index].exercise.id,
                            onToggleExplain: () {
                              setState(() {
                                _expandedExplanationId =
                                    _expandedExplanationId ==
                                        results[index].exercise.id
                                    ? null
                                    : results[index].exercise.id;
                              });
                            },
                            onSelect: () {
                              widget.onExerciseSelected(
                                results[index].exercise,
                              );
                              Navigator.pop(context);
                            },
                            onReject: () {
                              ref
                                  .read(exerciseDaoProvider)
                                  .rejectSubstitution(
                                    id: 'sf-${DateTime.now().millisecondsSinceEpoch}',
                                    userId:
                                        'local-user', // dynamic in production
                                    sourceExerciseId: widget.sourceExerciseId,
                                    rejectedExerciseId:
                                        results[index].exercise.id,
                                  )
                                  .then((_) {
                                    ref.invalidate(
                                      substitutionResultsProvider(
                                        widget.sourceExerciseId,
                                      ),
                                    );
                                  });
                            },
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyanAccent,
                      ),
                    ),
                    error: (error, stack) => Center(
                      child: Text(
                        'Error: $error',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showAddCustomExercise(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddCustomExerciseSheet(),
    );
  }

  void _showPersonalizationDashboard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PersonalizationDashboard(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onAddCustom;
  const _EmptyState({required this.onAddCustom});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 24),
          const Text(
            'No exact matches found.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Try relaxing your constraint filters.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            onPressed: onAddCustom,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Custom Exercise'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.cyanAccent,
              side: BorderSide(color: Colors.cyanAccent.withValues(alpha: 0.5)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterCTA extends StatelessWidget {
  final VoidCallback onAddCustom;
  const _FooterCTA({required this.onAddCustom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
      child: Column(
        children: [
          Text(
            'Still not seeing it?',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onAddCustom,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Custom Exercise'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.cyanAccent,
              side: BorderSide(color: Colors.cyanAccent.withValues(alpha: 0.3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  final SubstitutionResult result;
  final Exercise source;
  final bool isExpanded;
  final VoidCallback onToggleExplain;
  final VoidCallback onSelect;
  final VoidCallback onReject;

  const _ResultTile({
    required this.result,
    required this.source,
    required this.isExpanded,
    required this.onToggleExplain,
    required this.onSelect,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final exercise = result.exercise;
    final isHighMatch = result.similarityPercent > 80;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onSelect,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Exercise Icon (Placeholder for thumbnail)
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.fitness_center_rounded,
                          color: Colors.cyanAccent,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    exercise.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (exercise.tier == ExerciseTier.curated)
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Icon(
                                      Icons.verified_rounded,
                                      size: 14,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${exercise.equipment.name} • ${exercise.primaryMuscles.map((m) => m.muscle.name).join(", ")}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.6),
                              ),
                            ),
                            if (exercise.tier == ExerciseTier.aiInferred)
                              const Padding(
                                padding: EdgeInsets.only(top: 2.0),
                                child: Text(
                                  '🌟 Community-Driven',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                              ),
                            if (exercise.canonicalHash != null)
                              _CommunityConfidenceBar(
                                canonicalHash: exercise.canonicalHash!,
                              ),
                          ],
                        ),
                      ),
                      // Score
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isHighMatch
                                  ? Colors.greenAccent.withValues(alpha: 0.1)
                                  : Colors.orangeAccent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${result.similarityPercent.round()}%',
                              style: TextStyle(
                                color: isHighMatch
                                    ? Colors.greenAccent
                                    : Colors.orangeAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          if (result.constraintsRelaxed)
                            const Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Text(
                                'Relaxed',
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Action Bar
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                ),
                color: Colors.black.withValues(alpha: 0.1),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: onToggleExplain,
                    icon: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.info_outline_rounded,
                      size: 16,
                    ),
                    label: const Text(
                      'Why this?',
                      style: TextStyle(fontSize: 12),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: onReject,
                    icon: const Icon(Icons.thumb_down_rounded, size: 14),
                    label: const Text(
                      'Bad match',
                      style: TextStyle(fontSize: 12),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white38,
                    ),
                  ),
                ],
              ),
            ),

            // Expanded Explainability Pane
            if (isExpanded)
              Container(
                color: Colors.black.withValues(alpha: 0.2),
                padding: const EdgeInsets.all(16),
                child: SubstitutionExplanation(result: result, source: source),
              ),
          ],
        ),
      ),
    );
  }
}

/// Provider for exercise consensus data based on canonical hash.
final exerciseConsensusProvider =
    FutureProvider.family<GlobalConsensusResult?, String>((ref, hash) async {
      return ref.read(flywheelSyncServiceProvider).getExerciseConsensus(hash);
    });

/// Compact widget that displays the community confidence score
class _CommunityConfidenceBar extends ConsumerWidget {
  final String canonicalHash;
  const _CommunityConfidenceBar({required this.canonicalHash});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consensusAsync = ref.watch(exerciseConsensusProvider(canonicalHash));

    return consensusAsync.when(
      data: (consensus) {
        if (consensus == null) return const SizedBox.shrink();

        final progress = consensus.communityConfidence;
        final count = consensus.submissionCount;
        final threshold = GlobalConsensusResult.promotionThreshold;

        return Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 4,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      consensus.isPromotedToTier1
                          ? Colors.greenAccent
                          : Colors.purpleAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$count/$threshold',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withValues(alpha: 0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (consensus.isPromotedToTier1) ...[
                const SizedBox(width: 4),
                const Icon(
                  Icons.check_circle_rounded,
                  size: 12,
                  color: Colors.greenAccent,
                ),
              ],
            ],
          ),
        );
      },
      loading: () => const SizedBox(
        height: 4,
        child: LinearProgressIndicator(minHeight: 2),
      ),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
