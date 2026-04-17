import 'package:fit/features/ontology/data/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/gamification_providers.dart';

class MuscleLevelList extends ConsumerWidget {
  const MuscleLevelList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muscleExpAsync = ref.watch(muscleExperienceProvider);

    return muscleExpAsync.when(
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();

        // Sort by level/xp
        final sortedList = List.from(list)..sort((a, b) => b.xp.compareTo(a.xp));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MUSCLE MASTERY',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sortedList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = sortedList[index];
                return _buildMuscleLevelRow(item);
              },
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }

  Widget _buildMuscleLevelRow(MuscleExperienceData item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              item.muscleRegionId.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LVL ${item.level}',
                      style: const TextStyle(color: Colors.cyanAccent, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${item.xp} XP',
                      style: const TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    // Progress to next level
                    value: _calculateLevelProgress(item.xp, item.level),
                    backgroundColor: Colors.white10,
                    color: Colors.cyanAccent,
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateLevelProgress(int xp, int level) {
    final currentLevelXp = (level - 1) * (level - 1) * 100;
    final nextLevelXp = level * level * 100;
    final progress = (xp - currentLevelXp) / (nextLevelXp - currentLevelXp);
    return progress.clamp(0.0, 1.0);
  }
}
