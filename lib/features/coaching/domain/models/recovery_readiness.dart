enum RecoveryLevel {
  optimal,    // 80-100: Prime for PRs
  recovered,  // 60-79: Normal training
  restoring,  // 40-59: Moderate/Light allowed
  fatigued,   // 20-39: Deload recommended
  danger      // 0-19: Mandatory rest
}

class RecoveryReadiness {
  final double score;
  final RecoveryLevel level;
  final String recommendation;
  final Map<String, double> factorContributions;

  RecoveryReadiness({
    required this.score,
    required this.level,
    required this.recommendation,
    required this.factorContributions,
  });
}
