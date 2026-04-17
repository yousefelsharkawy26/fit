import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/core_providers.dart';
import '../../domain/models/muscle_fatigue_state.dart';

/// Provides a list of muscle fatigue states for the Visual Twin.
final visualTwinProvider = FutureProvider.autoDispose<List<MuscleFatigueState>>(
  (ref) async {
    final database = ref.watch(appDatabaseProvider);
    final dao = database.coachingDao;

    // Poll ACWR data from the database
    final acwrMap = await dao.getMuscleACWR('local-user');

    // Convert raw ACWR into domain states
    return acwrMap.entries.map((entry) {
      return MuscleFatigueState.fromACWR(entry.key, entry.value);
    }).toList();
  },
);

/// A convenience provider to get the fatigue state for a specific muscle group.
final muscleGroupFatigueProvider = Provider.autoDispose
    .family<MuscleFatigueState?, String>((ref, groupName) {
      final allStates = ref.watch(visualTwinProvider).asData?.value ?? [];
      try {
        return allStates.firstWhere(
          (state) => state.muscleGroup.toLowerCase() == groupName.toLowerCase(),
        );
      } catch (_) {
        return null;
      }
    });
