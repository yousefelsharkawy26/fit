import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/analytics_repository.dart';
import '../../domain/models/analytics_models.dart';

final biomechanicalLoadProvider = StreamProvider<BiomechanicalLoadSummary>((ref) {
  final repository = ref.watch(analyticsRepositoryProvider);
  // Current user is hardcoded to 'local-user' as per workspace rules
  return repository.watchLoadSummary('local-user');
});
