import 'package:fit/features/ontology/presentation/providers/ontology_data_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/coach_reasoning_engine.dart';
import '../../domain/services/context_building_service.dart';
import '../../domain/services/split_auditor_service.dart';
import '../../domain/models/coaching_context.dart';

/// Provider for the full AI Coaching state
final coachingDashboardProvider = FutureProvider.autoDispose<CoachingDashboardState>((ref) async {
  final contextService = ref.watch(contextBuildingServiceProvider);
  final auditorService = ref.watch(splitAuditorServiceProvider);
  
  // Watch constraints so the dashboard immediately rebuilds when injuries/soreness are toggled
  ref.watch(activeMuscleConstraintsProvider);
  
  const userId = 'local-user';
  
  final context = await contextService.buildContext(userId);
  final audit = auditorService.auditSplit(context, []); 
  
  return CoachingDashboardState(
    context: context,
    auditReport: audit,
  );
});

/// Separate provider for AI-generated insights 
final coachInsightProvider = FutureProvider.autoDispose<CoachResponse>((ref) async {
  final engine = ref.watch(coachReasoningEngineProvider);
  final contextService = ref.watch(contextBuildingServiceProvider);
  
  // Watch constraints to stay in sync with Dashboard
  ref.watch(activeMuscleConstraintsProvider);
  
  final context = await contextService.buildContext('local-user');
  return engine.analyzeAndRespond(context);
});

class CoachingDashboardState {
  final CoachingContext context;
  final AuditReport auditReport;

  CoachingDashboardState({required this.context, required this.auditReport});
}
