/// substitution_providers.dart
///
/// Reactive state for the In-Workout Substitution Engine HUD.
/// Consumes the foundational providers from core_providers.dart.
library;

//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// import 'package:fit/features/ontology/domain/models/ontology_models.dart';
// import 'package:fit/features/core/providers/core_providers.dart';

// Re-export the core providers so that any file importing substitution_providers
// can still access appDatabaseProvider, exerciseDaoProvider, etc.
export 'package:fit/features/core/providers/core_providers.dart';

// ---------------------------------------------------------------------------
// Equipment exclusion state (toggled by the Bottleneck Gate chips in the HUD)
// ---------------------------------------------------------------------------

final excludedEquipmentProvider = StateProvider<Set<String>>((ref) => const {});

// ---------------------------------------------------------------------------
// Reactive candidates list — rebuilds automatically whenever:
//   • a different exercise is being replaced (family key)
//   • the user adds/removes excluded equipment
// ---------------------------------------------------------------------------

// substitutionCandidatesProvider removed since we unified everything under SubstitutionService and substitutionResultsProvider.
