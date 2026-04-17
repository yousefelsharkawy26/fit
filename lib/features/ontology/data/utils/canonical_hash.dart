import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Canonical hash computation for the Data Flywheel.
///
/// When a user adds a Tier 2 exercise, we normalize the name and
/// compute a SHA-256 hash. This hash is sent to Supabase for
/// clustering: the server simply does GROUP BY canonical_hash
/// to count how many unique users have added the same exercise.
///
/// This turns an O(n²) Levenshtein string clustering problem
/// into an O(1) GROUP BY lookup.
///
/// See: exercise_ontology_design.md §7 — Trust Tiers & Sync
class CanonicalHash {
  CanonicalHash._();

  /// Normalize an exercise name for canonical hashing.
  ///
  /// Rules:
  /// - Convert to lowercase
  /// - Strip all non-alphanumeric characters (spaces, hyphens, punctuation)
  /// - This ensures "Skull Crusher", "skull-crusher", "Skullcrusher"
  ///   all produce the same hash.
  static String normalize(String name) {
    return name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '');
  }

  /// Compute SHA-256 hash of the normalized exercise name.
  static String compute(String exerciseName) {
    final normalized = normalize(exerciseName);
    final bytes = utf8.encode(normalized);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
