import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'flywheel_client.dart';

class SupabaseFlywheelClient implements FlywheelClient {
  final String url;
  final String anonKey;
  final HttpClient _client = HttpClient();

  SupabaseFlywheelClient({
    required this.url,
    required this.anonKey,
  });

  Map<String, String> get _headers => {
        'apikey': anonKey,
        'Authorization': 'Bearer $anonKey',
        'Content-Type': 'application/json',
      };

  @override
  Future<GlobalConsensusResult> submitExerciseVariant({
    required Map<String, dynamic> sanitizedPayload,
  }) async {
    try {
      final uri = Uri.parse('$url/rest/v1/rpc/submit_exercise_variant');
      final request = await _client.postUrl(uri);
      _headers.forEach((k, v) => request.headers.set(k, v));
      request.write(jsonEncode(sanitizedPayload));
      
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(body);
        return GlobalConsensusResult.fromCount(
          data['submission_count'] as int,
          hash: sanitizedPayload['canonical_hash'],
        );
      }
      debugPrint('Supabase Error: ${response.statusCode} $body');
    } catch (e) {
      debugPrint('Supabase Exception: $e');
    }
    // Return a default assuming the backend call failed.
    return GlobalConsensusResult.fromCount(0, hash: sanitizedPayload['canonical_hash']);
  }

  @override
  Future<void> reportRejection({
    required String sourceExerciseId,
    required String rejectedExerciseId,
  }) async {
    try {
      final uri = Uri.parse('$url/rest/v1/rpc/report_rejection');
      final request = await _client.postUrl(uri);
      _headers.forEach((k, v) => request.headers.set(k, v));
      request.write(jsonEncode({
        'source_id': sourceExerciseId,
        'rejected_id': rejectedExerciseId,
      }));
      await request.close();
    } catch (e) {
      debugPrint('Supabase Exception: $e');
    }
  }

  @override
  Future<GlobalConsensusResult?> getConsensus(String canonicalHash) async {
    try {
      final uri = Uri.parse('$url/rest/v1/rpc/get_consensus');
      final request = await _client.postUrl(uri);
      _headers.forEach((k, v) => request.headers.set(k, v));
      request.write(jsonEncode({'hash': canonicalHash}));
      
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(body);
        return GlobalConsensusResult.fromCount(
          data['submission_count'] as int,
          hash: canonicalHash,
        );
      }
    } catch (e) {
      debugPrint('Supabase Exception: $e');
    }
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> pullTier1Promotions({
    required DateTime since,
  }) async {
    try {
      final uri = Uri.parse('$url/rest/v1/rpc/pull_tier1_promotions');
      final request = await _client.postUrl(uri);
      _headers.forEach((k, v) => request.headers.set(k, v));
      request.write(jsonEncode({'since_date': since.toUtc().toIso8601String()}));
      
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(body);
        return data.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      debugPrint('Supabase Exception: $e');
    }
    return [];
  }

  @override
  void listenToPromotions(void Function(Map<String, dynamic> promotionEvent) onPromotion) {
    // Note: True Realtime requires a WebSocket connection via supabase_flutter.
    debugPrint('📡 SupabaseFlywheelClient: Realtime listener not initialized in REST stub.');
  }

  @override
  void dispose() {
    _client.close(force: true);
  }
}
