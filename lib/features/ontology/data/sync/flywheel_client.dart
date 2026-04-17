/// The result of a global consensus query for a specific exercise.
class GlobalConsensusResult {
  /// How many unique users have submitted this exact variant.
  final int submissionCount;

  /// The community confidence score (0.0 - 1.0).
  /// Calculated as: min(1.0, submissionCount / threshold)
  final double communityConfidence;

  /// Whether this exercise has been promoted to Tier 1 globally.
  final bool isPromotedToTier1;

  /// The canonical hash used for deduplication.
  final String? canonicalHash;

  const GlobalConsensusResult({
    required this.submissionCount,
    required this.communityConfidence,
    required this.isPromotedToTier1,
    this.canonicalHash,
  });

  /// The promotion threshold: how many unique submissions are needed 
  /// before an exercise is automatically promoted to Tier 1.
  static const int promotionThreshold = 5;

  /// Compute confidence from raw submission count.
  factory GlobalConsensusResult.fromCount(int count, {String? hash}) {
    return GlobalConsensusResult(
      submissionCount: count,
      communityConfidence: (count / promotionThreshold).clamp(0.0, 1.0),
      isPromotedToTier1: count >= promotionThreshold,
      canonicalHash: hash,
    );
  }
}

/// Abstraction over the Global Flywheel backend (Supabase).
///
/// This interface decouples the sync engine from the specific backend,
/// allowing us to run with a [MockFlywheelClient] during development
/// and swap to a [SupabaseFlywheelClient] for production.
abstract class FlywheelClient {
  /// Submit a sanitized exercise payload to the global consensus pool.
  /// Returns the updated [GlobalConsensusResult] for this exercise.
  Future<GlobalConsensusResult> submitExerciseVariant({
    required Map<String, dynamic> sanitizedPayload,
  });

  /// Report that a user rejected a substitution suggestion.
  /// This negative signal reduces the rejected exercise's global ranking.
  Future<void> reportRejection({
    required String sourceExerciseId,
    required String rejectedExerciseId,
  });

  /// Query the global consensus for a specific canonical hash.
  Future<GlobalConsensusResult?> getConsensus(String canonicalHash);

  /// Pull the latest Tier 1 promotions since the given timestamp.
  /// Returns a list of exercises that have been promoted to global ground truth.
  Future<List<Map<String, dynamic>>> pullTier1Promotions({
    required DateTime since,
  });

  /// Subscribe to real-time Tier 1 promotion events.
  /// The callback fires whenever a new exercise is promoted globally.
  void listenToPromotions(
    void Function(Map<String, dynamic> promotionEvent) onPromotion,
  );

  /// Dispose of any active subscriptions.
  void dispose();
}
