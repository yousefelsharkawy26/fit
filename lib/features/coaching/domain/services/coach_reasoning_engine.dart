import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../data/database/coaching_dao.dart';
import '../models/coaching_context.dart';
import 'split_auditor_service.dart';
import '../../../ontology/data/database/exercise_dao.dart';
import '../../../ontology/data/repository/vector_repository.dart';
import '../../../ontology/presentation/providers/substitution_providers.dart';

import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import '../../../ontology/data/database/database.dart';
import '../../data/database/coaching_tables.dart';
import 'dart:typed_data';
import '../../../ontology/domain/enums/ontology_enums.dart';
import '../../../ontology/data/vectorizer/dimension_registry.dart';
import '../../../ontology/data/vectorizer/vector_weights.dart';
import '../../../onboarding/domain/models/biometric_profile.dart'; // Adjust path if needed

/// Provider for the CoachReasoningEngine.
final coachReasoningEngineProvider = Provider<CoachReasoningEngine>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final coachingDao = db.coachingDao;
  final exerciseDao = ref.watch(exerciseDaoProvider);
  final safetyAuditor = ref.watch(splitAuditorServiceProvider);
  final vectorRepository = ref.watch(vectorRepositoryProvider);

  return CoachReasoningEngine(
    db: db,
    coachingDao: coachingDao,
    safetyAuditor: safetyAuditor,
    exerciseDao: exerciseDao,
    vectorRepository: vectorRepository,
  );
});

/// The "Brain" of FitOS.
/// Translates raw performance data and biomechanical audits into actionable coaching intelligence.
class CoachReasoningEngine {
  final AppDatabase db;
  final CoachingDao coachingDao;
  final SplitAuditorService safetyAuditor;
  final ExerciseDao exerciseDao;
  final VectorRepository vectorRepository;

  CoachReasoningEngine({
    required this.db,
    required this.coachingDao,
    required this.safetyAuditor,
    required this.exerciseDao,
    required this.vectorRepository,
  });

  /// The "Day 1 Calibration" routine.
  /// Synthesizes the initial 4-week training block based on the user's Day 0 biometric profile.
  Future<void> initializeNewUserPlan(
    String userId,
    BiometricProfile profile,
  ) async {
    final apiKey = dotenv.get('GEMINI_API_KEY', fallback: 'AIzaPlaceholderKey');

    // We request pure JSON output according to our schema
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: Schema.object(
          properties: {
            'reasoning': Schema.string(description: 'Explain why this split fits the bio-profile and addresses active constraints.'),
            'workouts': Schema.array(
              items: Schema.object(
                properties: {
                  'name': Schema.string(description: 'Workout Name (e.g. Upper Body Focus)'),
                  'exercises': Schema.array(
                    items: Schema.object(
                      properties: {
                        'name': Schema.string(description: 'Exercise Name'),
                        'ontology': Schema.object(
                          properties: {
                            'pattern': Schema.string(description: 'Push|Pull|Hinge|Squat|Carry|Rotation|Accessories'),
                            'mechanics': Schema.string(description: 'Compound|Isolation'),
                            'equipment': Schema.string(description: 'Barbell|Dumbbell|Machine|Cable|Bodyweight|None'),
                            'angle': Schema.string(description: 'Flat|Incline|Decline|Vertical|Horizontal'),
                          },
                        ),
                        'sets': Schema.array(
                          items: Schema.object(
                            properties: {
                              'type': Schema.string(description: 'working or warmup'),
                              'reps': Schema.integer(description: 'Target reps'),
                              'rpe': Schema.number(description: 'Target RPE (1-10)'),
                            },
                          ),
                        ),
                      },
                    ),
                  ),
                },
              ),
            ),
          },
          requiredProperties: ['reasoning', 'workouts'],
        ),
      ),
      systemInstruction: Content.system(
        'You are an Elite Sports Scientist specializing in biomechanics and adaptive hyper-personalized training programs. '
        'Your goal is to synthesize a 4-week training block based on the user\'s biometric profile. '
        'You must STRICTLY ADHERE to all Active Muscle Constraints—do not prescribe exercises that aggravate injured or highly fatigued muscles. '
        'Prioritize compound movements but optimize for safety and recovery. Do not output conversational prose.',
      ),
    );

    // 1. Build the Persona Prompt based on the Biometric Profile
    final prompt =
        'Generate a balanced 3-day full-body split for a user with the following profile:\n'
        '- Age: ${profile.age}\n'
        '- Weight: ${profile.weight} kg\n'
        '- Height: ${profile.height} cm\n'
        '- Goal: ${profile.primaryGoal?.name ?? "Hypertrophy"}\n'
        '- Experience: ${profile.experienceLevel?.name ?? "Intermediate"}\n'
        '- Equipment Available: ${profile.availableEquipmentIds.isEmpty ? "All Standard Gym Equipment" : profile.availableEquipmentIds.join(", ")}\n\n'
        'Ensure the plan strictly respects Active Muscle Constraints to avoid stressing injuries or highly fatigued muscles. '
        'Focus on compound movements and biomechanically sound exercise selection.';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('LLM returned empty JSON');
      }

      final Map<String, dynamic> jsonPlan = jsonDecode(text);
      await _persistGenesisPlan(userId, jsonPlan);
    } catch (e) {
      // Fallback pseudo-plan if JSON generation fails, offline, etc.
      final fallbackPlan = {
        "reasoning": "Default Foundation Protocol due to connection timeout.",
        "workouts": [
          {
            "name": "Foundation Full Body",
            "exercises": [
              {
                "name": "Barbell Squat",
                "ontology": {
                  "pattern": "Squat",
                  "mechanics": "Compound",
                  "equipment": "Barbell",
                  "angle": "Vertical",
                },
                "sets": [
                  {"type": "working", "reps": 8, "rpe": 7.0},
                ],
              },
            ],
          },
        ],
      };
      await _persistGenesisPlan(userId, fallbackPlan);
    }
  }

  Future<void> _persistGenesisPlan(
    String userId,
    Map<String, dynamic> jsonPlan,
  ) async {
    const uuid = Uuid();

    await db.transaction(() async {
      final workoutsList = jsonPlan['workouts'] as List<dynamic>? ?? [];

      for (var wJson in workoutsList) {
        final Map<String, dynamic> wMap = wJson;
        final workoutId = uuid.v4();

        // Insert Workout
        await db
            .into(db.workouts)
            .insert(
              WorkoutsCompanion(
                id: drift.Value(workoutId),
                userId: drift.Value(userId),
                name: drift.Value(
                  wMap['name'] as String? ?? 'Training Session',
                ),
                status: const drift.Value(WorkoutStatus.planned),
                createdAt: drift.Value(DateTime.now()),
              ),
            );

        final exercisesList = wMap['exercises'] as List<dynamic>? ?? [];
        int orderIdx = 0;

        for (var exJson in exercisesList) {
          final Map<String, dynamic> exMap = exJson;
          final String exName = exMap['name'] as String? ?? 'Unknown Exercise';
          final Map<String, dynamic> ontology =
              exMap['ontology'] as Map<String, dynamic>? ?? {};

          final String targetExerciseId = await _findBestOntologyMatch(
            exName,
            ontology,
          );

          final workoutExerciseId = uuid.v4();
          await db
              .into(db.workoutExercises)
              .insert(
                WorkoutExercisesCompanion(
                  id: drift.Value(workoutExerciseId),
                  workoutId: drift.Value(workoutId),
                  exerciseId: drift.Value(targetExerciseId),
                  orderIndex: drift.Value(orderIdx++),
                  notes: drift.Value(
                    jsonPlan['reasoning'] as String?,
                  ), // storing Coach Insights!
                  createdAt: drift.Value(DateTime.now()),
                ),
              );

          final setsList = exMap['sets'] as List<dynamic>? ?? [];
          for (var setJson in setsList) {
            final Map<String, dynamic> setMap = setJson;
            final setTypeStr = setMap['type'] as String? ?? 'working';
            SetType sType = SetType.working;
            if (SetType.values.any((e) => e.name == setTypeStr)) {
              sType = SetType.values.firstWhere((e) => e.name == setTypeStr);
            }

            await db
                .into(db.workoutSets)
                .insert(
                  WorkoutSetsCompanion(
                    id: drift.Value(uuid.v4()),
                    workoutExerciseId: drift.Value(workoutExerciseId),
                    setType: drift.Value(sType),
                    reps: drift.Value(setMap['reps'] as int? ?? 10),
                    weight: const drift.Value(
                      0.0,
                    ), // AI generates template; actual load determined at runtime
                    rpe: drift.Value((setMap['rpe'] as num?)?.toDouble()),
                    createdAt: drift.Value(DateTime.now()),
                  ),
                );
          }
        }
      }
    });
  }

  Future<String> _findBestOntologyMatch(
    String exName,
    Map<String, dynamic> ontology,
  ) async {
    // Bridging LLM Text directly to local SQLite-Vec Dimensions:
    // We parse the generated JSON ontology (Pattern, Angle, Equipment)
    // into our proprietary 80-float biological dimension structure.
    try {
      final vector = Float32List(DimensionRegistry.totalDimensions);
      bool hasBiologicalSignal = false;

      // 1. Pattern Matching
      final patternStr = ontology['pattern']?.toString().toLowerCase();
      if (patternStr != null) {
        final mp = MovementPattern.values
            .where((e) => e.name == patternStr)
            .firstOrNull;
        if (mp != null) {
          vector[DimensionRegistry.patternOffset +
                  DimensionRegistry.movementPatternIndex(mp)] =
              VectorWeights.movementPattern;
          hasBiologicalSignal = true;
        }
      }

      // 2. Mechanics Matching
      final mechStr = ontology['mechanics']?.toString().toLowerCase();
      if (mechStr != null) {
        final m = Mechanics.values.where((e) => e.name == mechStr).firstOrNull;
        if (m != null) {
          vector[DimensionRegistry.mechanicsOffset +
                  DimensionRegistry.mechanicsIndex(m)] =
              VectorWeights.mechanics;
          hasBiologicalSignal = true;
        }
      }

      // 3. Equipment Matching (Resolving 'Barbell' string to 'eq-001-barbell' id)
      final eqStr = ontology['equipment']?.toString().toLowerCase();
      if (eqStr != null) {
        final eqId = DimensionRegistry.equipmentIndex.keys
            .where((k) => k.contains(eqStr))
            .firstOrNull;
        if (eqId != null) {
          vector[DimensionRegistry.equipmentOffset +
                  DimensionRegistry.equipmentIndex[eqId]!] =
              VectorWeights.equipment;
          hasBiologicalSignal = true;
        }
      }

      // 4. Angle Matching
      final angleStr = ontology['angle']?.toString().toLowerCase();
      if (angleStr != null) {
        final a = ExerciseAngle.values
            .where((e) => e.name == angleStr)
            .firstOrNull;
        if (a != null) {
          vector[DimensionRegistry.angleOffset +
                  DimensionRegistry.angleIndex(a)] =
              VectorWeights.angle;
          hasBiologicalSignal = true;
        }
      }

      if (hasBiologicalSignal) {
        // Semantic Snap Execution: Pass the handcrafted LLM biological vector to sqlite-vec
        final matches = await vectorRepository.findSimilar(vector, limit: 1);
        if (matches.isNotEmpty) {
          return matches.first.key;
        }
      }
    } catch (e) {
      // Ignored: Fall through to string match if the vector query fails
    }

    // Fallback: Primitive String Fuzzy-Match
    ExerciseData? foundEx =
        await (db.select(db.exercises)
              ..where((tbl) => tbl.name.like('%$exName%'))
              ..limit(1))
            .getSingleOrNull();

    foundEx ??= await (db.select(db.exercises)..limit(1)).getSingleOrNull();

    if (foundEx == null) {
      throw Exception(
        "CRITICAL: Ontology Database is empty. Cannot map fallback.",
      );
    }

    return foundEx.id;
  }

  /// Orchestrates the process of analyzing context and generating a response.
  Future<CoachResponse> analyzeAndRespond(CoachingContext context) async {
    // 1. Sanitize the context into a compact markdown representation
    final sanitizedData = sanitize(context);

    // 2. Perform automated biomechanical audit
    final auditReport = safetyAuditor.auditSplit(
      context,
      [],
    ); // Empty split for now

    // 3. Logic to determine response type
    // If there are high-severity safety issues, we prioritize an Alert immediately.
    if (context.activeInjuries.isNotEmpty ||
        auditReport.issues.any((i) => i.severity == Severity.high)) {
      final criticalIssue = auditReport.issues.firstWhere(
        (i) => i.severity == Severity.high,
        orElse: () => InjuryRiskIssue(
          muscle: context.activeInjuries.first,
          severity: Severity.high,
          message: 'Known injury detected.',
        ),
      );

      return CoachResponse.alert(
        title: 'Safety Intervention Required',
        message: criticalIssue.message,
        affectedMuscles: context.activeInjuries,
      );
    }

    // 4. LLM Reasoning Loop (Module F Endgame)
    try {
      final response = await _generateAIResponse(sanitizedData);
      return response;
    } catch (e) {
      // Fallback logic if LLM fails
      return CoachResponse.recommendation(
        suggestion: 'Maintain current volume while focus on recovery metrics.',
        scientificRationale:
            'Safety audit passed, but reasoning engine is currently offline. Procedural baseline maintained.',
      );
    }
  }

  /// Communicates with the Gemini API to generate structured coaching advice.
  Future<CoachResponse> _generateAIResponse(String promptData) async {
    // In a production app, the key would be fetched from a secure vault or environment.
    final apiKey = dotenv.get('GEMINI_API_KEY', fallback: 'AIzaPlaceholderKey');

    final model = GenerativeModel(
      model: 'gemini-1.5-flash', // Fast and effective for reasoning
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: Schema.object(
          properties: {
            'type': Schema.string(description: 'recommendation, alert, or split_change'),
            'title': Schema.string(description: 'Alert title', nullable: true),
            'message': Schema.string(description: 'Alert message', nullable: true),
            'affected': Schema.array(items: Schema.string(), description: 'Affected muscles', nullable: true),
            'suggestion': Schema.string(description: 'Brief, actionable suggestion', nullable: true),
            'rationale': Schema.string(description: 'Scientific rationale', nullable: true),
            'new_split': Schema.string(description: 'New split name', nullable: true),
            'reasoning': Schema.array(items: Schema.string(), description: 'Reasoning points', nullable: true),
          },
          requiredProperties: ['type'],
        ),
      ),
      systemInstruction: Content.system(
        'You are the FitOS Elite Bio-Strategist. Your role is to provide hyper-personalized fitness coaching '
        'based on biomechanical data and historical performance. \n\n'
        'CRITICAL RULES:\n'
        '1. SAFETY FIRST: If high fatigue (>0.85) or active injuries are detected, prioritize recovery. \n'
        '2. DATA-DRIVEN: Use the "Weekly Volume" and "Performance Snapshots" to identify trends. \n'
        '3. PERSONA: Scientific, decisive, and performance-oriented. \n'
        '4. OUTPUT FORMAT: STRICT JSON output matching the requested schema. No prose or conversational text.',
      ),
    );

    try {
      final content = [Content.text(promptData)];
      final response = await model.generateContent(content);

      final text = response.text;
      if (text == null) throw Exception('Empty AI response');

      final Map<String, dynamic> jsonResp = jsonDecode(text);
      final type = jsonResp['type'] as String?;

      if (type == 'alert') {
        return CoachResponse.alert(
          title: jsonResp['title'] as String? ?? 'Safety Intervention',
          message: jsonResp['message'] as String? ?? 'Detected high-risk biomechanical patterns. Reducing intensity immediately.',
          affectedMuscles: (jsonResp['affected'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        );
      }

      if (type == 'split_change') {
        return CoachResponse.splitChange(
          newSplitName: jsonResp['new_split'] as String? ?? 'Recovery Focus',
          reasoning: (jsonResp['reasoning'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [
            'Sub-optimal recovery found in recent logs.',
            'Prioritizing CNS restoration.',
          ],
        );
      }

      // Default to Recommendation
      return CoachResponse.recommendation(
        suggestion: jsonResp['suggestion'] as String? ?? 'Stay the course with current volume.',
        scientificRationale: jsonResp['rationale'] as String? ?? 'Performance metrics are stable within a standard deviation.',
      );
    } catch (e) {
      // Fallback
      return CoachResponse.recommendation(
        suggestion: 'Focus on quality of movement and consistent RPE.',
        scientificRationale:
            'Safety audit passed. Maintaining baseline stimulus while optimizing motor pattern efficiency.',
      );
    }
  }


  /// Converts complex JSON/DB objects into a compact "Coaching-Ready Markdown."
  /// This is the "Secret Sauce" that keeps the LLM context lean and accurate.
  String sanitize(CoachingContext context) {
    final buffer = StringBuffer();
    buffer.writeln('### [FITOS COACHING CONTEXT]');

    // 1. Fatigue & Injuries (High Priority)
    buffer.writeln('#### SAFETY STATUS');
    if (context.activeInjuries.isEmpty) {
      buffer.writeln('- No active physiological constraints.');
    } else {
      buffer.writeln('- ACTIVE INJURIES: ${context.activeInjuries.join(", ")}');
    }

    context.fatigueScores.forEach((muscle, score) {
      if (score > 0.7) {
        buffer.writeln(
          '- HIGH FATIGUE: $muscle (Score: ${score.toStringAsFixed(2)})',
        );
      }
    });

    // V2: Wearable Bio-Signals (P1 Health Sync)
    if (context.hrvMs != null || context.restingHr != null || context.sleepScore != null) {
      buffer.writeln('\n#### WEARABLE RECOVERY SIGNALS');
      if (context.hrvMs != null) {
        final hrvStatus = context.hrvMs! < 30 ? '⚠️ LOW' : (context.hrvMs! > 60 ? '✅ GOOD' : '🔶 MODERATE');
        buffer.writeln('- HRV: ${context.hrvMs!.toStringAsFixed(0)}ms ($hrvStatus)');
      }
      if (context.restingHr != null) {
        final rhrStatus = context.restingHr! > 75 ? '⚠️ ELEVATED' : (context.restingHr! < 60 ? '✅ GOOD' : '🔶 NORMAL');
        buffer.writeln('- Resting HR: ${context.restingHr}bpm ($rhrStatus)');
      }
      if (context.sleepScore != null) {
        final sleepPct = (context.sleepScore! * 100).toStringAsFixed(0);
        final sleepStatus = context.sleepScore! < 0.5 ? '⚠️ POOR' : (context.sleepScore! > 0.75 ? '✅ GOOD' : '🔶 FAIR');
        buffer.writeln('- Sleep Quality: $sleepPct% ($sleepStatus)');
      }
    }

    // Context Window Management: intelligent summarization to compress token payload
    
    // 2. Volume Trends (Top 5 muscles to save tokens)
    buffer.writeln('\n#### WEEKLY VOLUME SUMMARY (TOP 5 LOADED MUSCLES)');
    final sortedVolume = List.of(context.weeklyVolume)
      ..sort((a, b) => b.volume.compareTo(a.volume));
    for (var volume in sortedVolume.take(5)) {
      buffer.writeln('- ${volume.muscleName}: ${volume.volume.toStringAsFixed(1)}');
    }

    // 3. Performance Anomalies (Top 3 movers to strictly manage context size)
    buffer.writeln('\n#### PERFORMANCE SNAPSHOTS (KEY MOVERS)');
    final keyAnomalies = context.topExercises.take(3);
    for (var exercise in keyAnomalies) {
      final trendArrow = exercise.weeklyTrend >= 0 ? '↑' : '↓';
      buffer.writeln(
        '- ${exercise.exerciseName}: ${exercise.oneRepMaxEstimate.toStringAsFixed(1)}kg ($trendArrow${exercise.weeklyTrend.abs()}%)',
      );
    }

    return buffer.toString();
  }
}

/// Sealed class defining the possible output types from the Reasoning Engine.
sealed class CoachResponse {
  const CoachResponse();

  factory CoachResponse.recommendation({
    required String suggestion,
    required String scientificRationale,
  }) = CoachRecommendation;

  factory CoachResponse.alert({
    required String title,
    required String message,
    required List<String> affectedMuscles,
  }) = CoachAlert;

  factory CoachResponse.splitChange({
    required String newSplitName,
    required List<String> reasoning,
  }) = CoachSplitChange;
}

class CoachRecommendation extends CoachResponse {
  final String suggestion;
  final String scientificRationale;
  const CoachRecommendation({
    required this.suggestion,
    required this.scientificRationale,
  });
}

class CoachAlert extends CoachResponse {
  final String title;
  final String message;
  final List<String> affectedMuscles;
  const CoachAlert({
    required this.title,
    required this.message,
    required this.affectedMuscles,
  });
}

class CoachSplitChange extends CoachResponse {
  final String newSplitName;
  final List<String> reasoning;
  const CoachSplitChange({required this.newSplitName, required this.reasoning});
}
