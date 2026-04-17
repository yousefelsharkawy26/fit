import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fit/features/auth/presentation/providers/auth_providers.dart';
import 'package:fit/features/core/providers/core_providers.dart';
import 'package:fit/features/ontology/domain/models/ontology_models.dart';

// Re-export so consumers of this file also get exerciseDaoProvider, etc.
export 'package:fit/features/core/providers/core_providers.dart';

/// Provides all available muscle regions for selection.
final allMuscleRegionsProvider = FutureProvider<List<MuscleRegion>>((ref) async {
  final dao = ref.watch(exerciseDaoProvider);
  return dao.getAllMuscleRegions();
});

/// Provides all available equipment types for selection.
final allEquipmentProvider = FutureProvider<List<EquipmentModel>>((ref) async {
  final dao = ref.watch(exerciseDaoProvider);
  return dao.getAllEquipment();
});

/// Current User ID derived from Auth state. Falls back to offline-first identity.
final currentUserIdProvider = Provider<String>((ref) {
  final authState = ref.watch(authProvider);
  return authState.userId;
});

/// Stream of active muscle constraints for the current user.
final activeMuscleConstraintsProvider =
    StreamProvider<List<MuscleConstraint>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  final dao = ref.watch(exerciseDaoProvider);
  return dao.watchActiveMuscleConstraints(userId);
});

/// Stream of exercise preferences for the current user.
final userPreferencesProvider =
    FutureProvider<List<ExercisePreference>>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  final dao = ref.watch(exerciseDaoProvider);
  return dao.getExercisePreferences(userId);
});
