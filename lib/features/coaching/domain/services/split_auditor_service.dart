import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coaching_context.dart';

final splitAuditorServiceProvider = Provider<SplitAuditorService>((ref) {
  return SplitAuditorService();
});

class SplitAuditorService {
  /// Audits a proposed workout split for volume imbalances and recovery risks.
  AuditReport auditSplit(CoachingContext context, List<PlannedWorkout> split) {
    final issues = <AuditIssue>[];
    
    // 1. Check for Injury Violations (Module D Hard-Stops)
    for (var muscleId in context.activeInjuries) {
      issues.add(InjuryRiskIssue(
        muscle: muscleId,
        severity: Severity.high,
        message: 'Active Injury Protocol: $muscleId. Biomechanical load is restricted.',
      ));

      for (var workout in split) {
        for (var exercise in workout.exercises) {
          // Note: Exercises in PlannedWorkout are dynamic for now, 
          // but we expect them to have target muscle info.
          // This simulates a deep biomechanical check.
          if (exercise is String && exercise.toLowerCase().contains(muscleId.toLowerCase())) {
             issues.add(InjuryRiskIssue(
              muscle: muscleId,
              severity: Severity.high,
              message: 'Exercise targeting $muscleId is contraindicated due to active injury.',
            ));
          }
        }
      }
    }

    // 2. Check for Overlapping Fatigue (The "Red Zone")
    // If a muscle has 0.8+ fatigue score from the last week, adding more high-intensity sets is an issue
    context.fatigueScores.forEach((muscle, score) {
      if (score > 0.8) {
        issues.add(OvertrainingIssue(
          muscle: muscle,
          severity: Severity.high,
          message: '$muscle is currently in a high fatigue state ($score). Adding more volume today increases injury risk.',
          fatigueScore: score,
        ));
      }
    });

    // 3. Check for Ontological Gaps (Missing Muscle Groups)
    // If a well-rounded hypertrophy split is desired, but Hamstrings have 0 volume.
    // ... logic to detect missing stimulus ...

    return AuditReport(
      isBalanced: issues.isEmpty,
      issues: issues,
      suggestions: _generateSuggestions(issues),
    );
  }

  List<String> _generateSuggestions(List<AuditIssue> issues) {
    // Uses the substitution logic to suggest alternatives
    return issues.map((i) => 'Consider swapping high-impact movements for ${i.muscle} with isolation or lower-CNS alternatives.').toList();
  }
}

class PlannedWorkout {
  final String name;
  final List<dynamic> exercises;
  PlannedWorkout(this.name, this.exercises);
}

enum Severity { low, medium, high }

sealed class AuditIssue {
  final String muscle;
  final Severity severity;
  final String message;

  const AuditIssue({required this.muscle, required this.severity, required this.message});
}

class InjuryRiskIssue extends AuditIssue {
  const InjuryRiskIssue({required super.muscle, required super.severity, required super.message});
}

class OvertrainingIssue extends AuditIssue {
  final double fatigueScore;
  const OvertrainingIssue({required super.muscle, required super.severity, required super.message, required this.fatigueScore});
}

class OntologicalGapIssue extends AuditIssue {
  const OntologicalGapIssue({required super.muscle, required super.severity, required super.message});
}

class AuditReport {
  final bool isBalanced;
  final List<AuditIssue> issues;
  final List<String> suggestions;

  AuditReport({required this.isBalanced, required this.issues, required this.suggestions});
}
