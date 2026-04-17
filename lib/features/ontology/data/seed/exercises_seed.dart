import 'muscle_regions_seed.dart';
import 'equipment_seed.dart';

/// 50 expert-tagged Tier 1 exercises covering all movement patterns,
/// equipment types, and lateralities.
///
/// Each exercise includes full junction data for exercise_muscles
/// (primary + secondary roles) and aliases where applicable.
///
/// See: exercise_ontology_design.md §4
///
/// Format:
/// - `exercise`: row data for the `exercises` table
/// - `muscles`: list of {muscle_name, role} for the `exercise_muscles` junction
/// - `aliases`: list of alternate names for the `exercise_aliases` table

class ExercisesSeed {
  ExercisesSeed._();

  static final _mr = MuscleRegionSeed.nameToId;
  static final _eq = EquipmentSeed.nameToId;

  static final List<Map<String, dynamic>> data = [
    // ═══════════════════════════════════════════════════════
    //  PUSH — Chest Dominant
    // ═══════════════════════════════════════════════════════
    _exercise(
      id: 'ex-001',
      name: 'Barbell Bench Press',
      equipment: 'Barbell',
      pattern: 'push', angle: 'flat', laterality: 'bilateral',
      loading: 'axial', cns: 'high', skill: 'intermediate', mechanics: 'compound',
      primary: ['Mid Chest'],
      secondary: ['Anterior Delt', 'Triceps (Medial/Lateral)'],
      aliases: ['Flat Bench Press', 'Flat Barbell Bench'],
    ),
    _exercise(
      id: 'ex-002',
      name: 'Incline Barbell Bench Press',
      equipment: 'Barbell',
      pattern: 'push', angle: 'incline', laterality: 'bilateral',
      loading: 'axial', cns: 'high', skill: 'intermediate', mechanics: 'compound',
      primary: ['Upper Chest'],
      secondary: ['Anterior Delt', 'Triceps (Medial/Lateral)'],
      aliases: ['Incline Bench', 'Incline Barbell Press'],
    ),
    _exercise(
      id: 'ex-003',
      name: 'Dumbbell Bench Press',
      equipment: 'Dumbbell',
      pattern: 'push', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Mid Chest'],
      secondary: ['Anterior Delt', 'Triceps (Medial/Lateral)'],
      aliases: ['Flat DB Bench Press', 'DB Bench'],
    ),
    _exercise(
      id: 'ex-004',
      name: 'Incline Dumbbell Bench Press',
      equipment: 'Dumbbell',
      pattern: 'push', angle: 'incline', laterality: 'bilateral',
      loading: 'peripheral', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Upper Chest'],
      secondary: ['Anterior Delt', 'Triceps (Medial/Lateral)'],
      aliases: ['Incline DB Press'],
    ),
    _exercise(
      id: 'ex-005',
      name: 'Decline Barbell Bench Press',
      equipment: 'Barbell',
      pattern: 'push', angle: 'decline', laterality: 'bilateral',
      loading: 'axial', cns: 'medium', skill: 'intermediate', mechanics: 'compound',
      primary: ['Lower Chest'],
      secondary: ['Anterior Delt', 'Triceps (Medial/Lateral)'],
      aliases: ['Decline Bench'],
    ),
    _exercise(
      id: 'ex-006',
      name: 'Cable Fly',
      equipment: 'Cable',
      pattern: 'push', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Mid Chest'],
      secondary: ['Anterior Delt'],
      aliases: ['Cable Crossover', 'Cable Chest Fly'],
    ),
    _exercise(
      id: 'ex-007',
      name: 'Machine Chest Press',
      equipment: 'Machine',
      pattern: 'push', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'compound',
      primary: ['Mid Chest'],
      secondary: ['Anterior Delt', 'Triceps (Medial/Lateral)'],
      aliases: ['Chest Press Machine'],
    ),
    _exercise(
      id: 'ex-008',
      name: 'Push-Up',
      equipment: 'Bodyweight',
      pattern: 'push', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'compound',
      primary: ['Mid Chest'],
      secondary: ['Anterior Delt', 'Triceps (Medial/Lateral)', 'Rectus Abdominis'],
      aliases: ['Press-Up'],
    ),

    // ═══════════════════════════════════════════════════════
    //  PUSH — Shoulder Dominant
    // ═══════════════════════════════════════════════════════
    _exercise(
      id: 'ex-009',
      name: 'Overhead Press',
      equipment: 'Barbell',
      pattern: 'push', angle: 'vertical', laterality: 'bilateral',
      loading: 'axial', cns: 'high', skill: 'intermediate', mechanics: 'compound',
      primary: ['Anterior Delt'],
      secondary: ['Lateral Delt', 'Triceps (Medial/Lateral)', 'Upper Traps'],
      aliases: ['OHP', 'Military Press', 'Barbell Shoulder Press'],
    ),
    _exercise(
      id: 'ex-010',
      name: 'Dumbbell Shoulder Press',
      equipment: 'Dumbbell',
      pattern: 'push', angle: 'vertical', laterality: 'bilateral',
      loading: 'peripheral', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Anterior Delt'],
      secondary: ['Lateral Delt', 'Triceps (Medial/Lateral)'],
      aliases: ['DB Shoulder Press', 'Seated DB Press'],
    ),
    _exercise(
      id: 'ex-011',
      name: 'Lateral Raise',
      equipment: 'Dumbbell',
      pattern: 'push', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Lateral Delt'],
      secondary: [],
      aliases: ['Side Raise', 'DB Lateral Raise'],
    ),
    _exercise(
      id: 'ex-012',
      name: 'Cable Lateral Raise',
      equipment: 'Cable',
      pattern: 'push', angle: 'flat', laterality: 'unilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Lateral Delt'],
      secondary: [],
      aliases: ['Single Arm Cable Lateral Raise'],
    ),

    // ═══════════════════════════════════════════════════════
    //  PUSH — Triceps
    // ═══════════════════════════════════════════════════════
    _exercise(
      id: 'ex-013',
      name: 'Lying Tricep Extension',
      equipment: 'Barbell',
      pattern: 'push', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'intermediate', mechanics: 'isolation',
      primary: ['Triceps (Long Head)'],
      secondary: ['Triceps (Medial/Lateral)'],
      aliases: ['Skull Crusher', 'French Press', 'Nose Breaker'],
    ),
    _exercise(
      id: 'ex-014',
      name: 'Cable Tricep Pushdown',
      equipment: 'Cable',
      pattern: 'push', angle: 'vertical', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Triceps (Medial/Lateral)'],
      secondary: [],
      aliases: ['Tricep Pushdown', 'Rope Pushdown'],
    ),
    _exercise(
      id: 'ex-015',
      name: 'Overhead Tricep Extension',
      equipment: 'Dumbbell',
      pattern: 'push', angle: 'vertical', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Triceps (Long Head)'],
      secondary: ['Triceps (Medial/Lateral)'],
      aliases: ['DB Overhead Extension'],
    ),
    _exercise(
      id: 'ex-016',
      name: 'Dips',
      equipment: 'Bodyweight',
      pattern: 'push', angle: 'decline', laterality: 'bilateral',
      loading: 'axial', cns: 'medium', skill: 'intermediate', mechanics: 'compound',
      primary: ['Lower Chest', 'Triceps (Medial/Lateral)'],
      secondary: ['Anterior Delt'],
      aliases: ['Chest Dips', 'Parallel Bar Dips'],
    ),

    // ═══════════════════════════════════════════════════════
    //  PULL — Back Dominant
    // ═══════════════════════════════════════════════════════
    _exercise(
      id: 'ex-017',
      name: 'Barbell Row',
      equipment: 'Barbell',
      pattern: 'pull', angle: 'flat', laterality: 'bilateral',
      loading: 'axial', cns: 'high', skill: 'intermediate', mechanics: 'compound',
      primary: ['Upper Lats', 'Rhomboids/Mid Traps'],
      secondary: ['Biceps (Short Head)', 'Erectors', 'Posterior Delt'],
      aliases: ['Bent Over Row', 'BB Row', 'Pendlay Row'],
    ),
    _exercise(
      id: 'ex-018',
      name: 'Dumbbell Row',
      equipment: 'Dumbbell',
      pattern: 'pull', angle: 'flat', laterality: 'unilateral',
      loading: 'peripheral', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Upper Lats', 'Rhomboids/Mid Traps'],
      secondary: ['Biceps (Short Head)', 'Posterior Delt'],
      aliases: ['Single Arm DB Row', 'One Arm Row'],
    ),
    _exercise(
      id: 'ex-019',
      name: 'Pull-Up',
      equipment: 'Bodyweight',
      pattern: 'pull', angle: 'vertical', laterality: 'bilateral',
      loading: 'axial', cns: 'high', skill: 'intermediate', mechanics: 'compound',
      primary: ['Upper Lats'],
      secondary: ['Lower Lats', 'Biceps (Long Head)', 'Rhomboids/Mid Traps'],
      aliases: ['Chin-Up Overhand'],
    ),
    _exercise(
      id: 'ex-020',
      name: 'Lat Pulldown',
      equipment: 'Cable',
      pattern: 'pull', angle: 'vertical', laterality: 'bilateral',
      loading: 'peripheral', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Upper Lats'],
      secondary: ['Lower Lats', 'Biceps (Short Head)'],
      aliases: ['Wide Grip Pulldown', 'Cable Pulldown'],
    ),
    _exercise(
      id: 'ex-021',
      name: 'Cable Row',
      equipment: 'Cable',
      pattern: 'pull', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Rhomboids/Mid Traps', 'Lower Lats'],
      secondary: ['Biceps (Short Head)', 'Posterior Delt'],
      aliases: ['Seated Cable Row', 'Low Row'],
    ),
    _exercise(
      id: 'ex-022',
      name: 'Face Pull',
      equipment: 'Cable',
      pattern: 'pull', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Posterior Delt'],
      secondary: ['Rhomboids/Mid Traps', 'Upper Traps'],
      aliases: ['Rope Face Pull'],
    ),
    _exercise(
      id: 'ex-023',
      name: 'Machine Row',
      equipment: 'Machine',
      pattern: 'pull', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'compound',
      primary: ['Rhomboids/Mid Traps', 'Upper Lats'],
      secondary: ['Biceps (Short Head)'],
      aliases: ['Chest-Supported Row Machine'],
    ),

    // ═══════════════════════════════════════════════════════
    //  PULL — Biceps
    // ═══════════════════════════════════════════════════════
    _exercise(
      id: 'ex-024',
      name: 'Barbell Curl',
      equipment: 'Barbell',
      pattern: 'pull', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Biceps (Short Head)'],
      secondary: ['Biceps (Long Head)', 'Forearms'],
      aliases: ['BB Curl', 'Standing Barbell Curl'],
    ),
    _exercise(
      id: 'ex-025',
      name: 'Dumbbell Curl',
      equipment: 'Dumbbell',
      pattern: 'pull', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Biceps (Short Head)'],
      secondary: ['Biceps (Long Head)'],
      aliases: ['DB Curl', 'Standing DB Curl'],
    ),
    _exercise(
      id: 'ex-026',
      name: 'Incline Dumbbell Curl',
      equipment: 'Dumbbell',
      pattern: 'pull', angle: 'incline', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Biceps (Long Head)'],
      secondary: ['Biceps (Short Head)'],
      aliases: ['Incline Curl'],
    ),
    _exercise(
      id: 'ex-027',
      name: 'Hammer Curl',
      equipment: 'Dumbbell',
      pattern: 'pull', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Biceps (Long Head)'],
      secondary: ['Forearms'],
      aliases: ['DB Hammer Curl'],
    ),

    // ═══════════════════════════════════════════════════════
    //  SQUAT
    // ═══════════════════════════════════════════════════════
    _exercise(
      id: 'ex-028',
      name: 'Barbell Back Squat',
      equipment: 'Barbell',
      pattern: 'squat', angle: 'flat', laterality: 'bilateral',
      loading: 'axial', cns: 'high', skill: 'intermediate', mechanics: 'compound',
      primary: ['Quads (Rectus Femoris bias)'],
      secondary: ['Glutes (Max)', 'Erectors', 'Quads (VMO bias)'],
      aliases: ['Back Squat', 'BB Squat', 'Squat'],
    ),
    _exercise(
      id: 'ex-029',
      name: 'Barbell Front Squat',
      equipment: 'Barbell',
      pattern: 'squat', angle: 'flat', laterality: 'bilateral',
      loading: 'axial', cns: 'high', skill: 'advanced', mechanics: 'compound',
      primary: ['Quads (Rectus Femoris bias)', 'Quads (VMO bias)'],
      secondary: ['Glutes (Max)', 'Rectus Abdominis'],
      aliases: ['Front Squat'],
    ),
    _exercise(
      id: 'ex-030',
      name: 'Goblet Squat',
      equipment: 'Dumbbell',
      pattern: 'squat', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'compound',
      primary: ['Quads (Rectus Femoris bias)'],
      secondary: ['Glutes (Max)'],
      aliases: ['DB Goblet Squat'],
    ),
    _exercise(
      id: 'ex-031',
      name: 'Bulgarian Split Squat',
      equipment: 'Dumbbell',
      pattern: 'squat', angle: 'flat', laterality: 'unilateral',
      loading: 'peripheral', cns: 'medium', skill: 'intermediate', mechanics: 'compound',
      primary: ['Quads (Rectus Femoris bias)'],
      secondary: ['Glutes (Max)', 'Glutes (Med/Min)'],
      aliases: ['BSS', 'Rear Foot Elevated Split Squat'],
    ),
    _exercise(
      id: 'ex-032',
      name: 'Leg Press',
      equipment: 'Machine',
      pattern: 'squat', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Quads (Rectus Femoris bias)'],
      secondary: ['Glutes (Max)'],
      aliases: ['45-Degree Leg Press'],
    ),
    _exercise(
      id: 'ex-033',
      name: 'Leg Extension',
      equipment: 'Machine',
      pattern: 'squat', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Quads (Rectus Femoris bias)', 'Quads (VMO bias)'],
      secondary: [],
      aliases: ['Quad Extension'],
    ),
    _exercise(
      id: 'ex-034',
      name: 'Walking Lunge',
      equipment: 'Dumbbell',
      pattern: 'squat', angle: 'flat', laterality: 'unilateral',
      loading: 'peripheral', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Quads (Rectus Femoris bias)'],
      secondary: ['Glutes (Max)', 'Glutes (Med/Min)'],
      aliases: ['DB Walking Lunge', 'Forward Lunge'],
    ),

    // ═══════════════════════════════════════════════════════
    //  HINGE
    // ═══════════════════════════════════════════════════════
    _exercise(
      id: 'ex-035',
      name: 'Conventional Deadlift',
      equipment: 'Barbell',
      pattern: 'hinge', angle: 'flat', laterality: 'bilateral',
      loading: 'axial', cns: 'high', skill: 'intermediate', mechanics: 'compound',
      primary: ['Glutes (Max)', 'Hamstrings'],
      secondary: ['Erectors', 'Quads (Rectus Femoris bias)', 'Upper Traps', 'Forearms'],
      aliases: ['Deadlift', 'BB Deadlift'],
    ),
    _exercise(
      id: 'ex-036',
      name: 'Romanian Deadlift',
      equipment: 'Barbell',
      pattern: 'hinge', angle: 'flat', laterality: 'bilateral',
      loading: 'axial', cns: 'high', skill: 'intermediate', mechanics: 'compound',
      primary: ['Hamstrings', 'Glutes (Max)'],
      secondary: ['Erectors'],
      aliases: ['RDL', 'Stiff-Legged Deadlift'],
    ),
    _exercise(
      id: 'ex-037',
      name: 'Dumbbell Romanian Deadlift',
      equipment: 'Dumbbell',
      pattern: 'hinge', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Hamstrings', 'Glutes (Max)'],
      secondary: ['Erectors'],
      aliases: ['DB RDL'],
    ),
    _exercise(
      id: 'ex-038',
      name: 'Single-Leg Romanian Deadlift',
      equipment: 'Dumbbell',
      pattern: 'hinge', angle: 'flat', laterality: 'unilateral',
      loading: 'peripheral', cns: 'medium', skill: 'intermediate', mechanics: 'compound',
      primary: ['Hamstrings', 'Glutes (Max)'],
      secondary: ['Glutes (Med/Min)', 'Erectors'],
      aliases: ['Single Leg RDL', 'SLRDL'],
    ),
    _exercise(
      id: 'ex-039',
      name: 'Hip Thrust',
      equipment: 'Barbell',
      pattern: 'hinge', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Glutes (Max)'],
      secondary: ['Hamstrings'],
      aliases: ['Barbell Hip Thrust', 'Glute Bridge (Weighted)'],
    ),
    _exercise(
      id: 'ex-040',
      name: 'Lying Leg Curl',
      equipment: 'Machine',
      pattern: 'hinge', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Hamstrings'],
      secondary: ['Calves'],
      aliases: ['Hamstring Curl', 'Prone Leg Curl'],
    ),
    _exercise(
      id: 'ex-041',
      name: 'Kettlebell Swing',
      equipment: 'Kettlebell',
      pattern: 'hinge', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'medium', skill: 'intermediate', mechanics: 'compound',
      primary: ['Glutes (Max)', 'Hamstrings'],
      secondary: ['Erectors', 'Rectus Abdominis'],
      aliases: ['KB Swing', 'Russian Swing'],
    ),

    // ═══════════════════════════════════════════════════════
    //  CARRY
    // ═══════════════════════════════════════════════════════
    _exercise(
      id: 'ex-042',
      name: 'Farmer Walk',
      equipment: 'Dumbbell',
      pattern: 'carry', angle: 'flat', laterality: 'bilateral',
      loading: 'axial', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Upper Traps', 'Forearms'],
      secondary: ['Obliques', 'Transverse Abdominis', 'Erectors'],
      aliases: ['Farmer Carry', 'Loaded Carry'],
    ),
    _exercise(
      id: 'ex-043',
      name: 'Suitcase Carry',
      equipment: 'Dumbbell',
      pattern: 'carry', angle: 'flat', laterality: 'unilateral',
      loading: 'axial', cns: 'medium', skill: 'beginner', mechanics: 'compound',
      primary: ['Obliques', 'Upper Traps'],
      secondary: ['Forearms', 'Transverse Abdominis'],
      aliases: ['Single Arm Carry'],
    ),

    // ═══════════════════════════════════════════════════════
    //  ROTATION
    // ═══════════════════════════════════════════════════════
    _exercise(
      id: 'ex-044',
      name: 'Cable Woodchop',
      equipment: 'Cable',
      pattern: 'rotation', angle: 'flat', laterality: 'unilateral',
      loading: 'peripheral', cns: 'low', skill: 'intermediate', mechanics: 'compound',
      primary: ['Obliques'],
      secondary: ['Transverse Abdominis', 'Rectus Abdominis'],
      aliases: ['Wood Chop', 'Cable Chop'],
    ),
    _exercise(
      id: 'ex-045',
      name: 'Pallof Press',
      equipment: 'Cable',
      pattern: 'rotation', angle: 'flat', laterality: 'unilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Transverse Abdominis', 'Obliques'],
      secondary: ['Rectus Abdominis'],
      aliases: ['Anti-Rotation Press'],
    ),

    // ═══════════════════════════════════════════════════════
    //  ADDITIONAL — Mixed / Core
    // ═══════════════════════════════════════════════════════
    _exercise(
      id: 'ex-046',
      name: 'Barbell Shrug',
      equipment: 'Barbell',
      pattern: 'pull', angle: 'flat', laterality: 'bilateral',
      loading: 'axial', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Upper Traps'],
      secondary: ['Forearms'],
      aliases: ['BB Shrug', 'Trap Shrug'],
    ),
    _exercise(
      id: 'ex-047',
      name: 'Hanging Leg Raise',
      equipment: 'Bodyweight',
      pattern: 'pull', angle: 'vertical', laterality: 'bilateral',
      loading: 'peripheral', cns: 'medium', skill: 'intermediate', mechanics: 'isolation',
      primary: ['Rectus Abdominis'],
      secondary: ['Obliques'],
      aliases: ['Leg Raise', 'Hanging Knee Raise'],
    ),
    _exercise(
      id: 'ex-048',
      name: 'Standing Calf Raise',
      equipment: 'Machine',
      pattern: 'push', angle: 'vertical', laterality: 'bilateral',
      loading: 'axial', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Calves'],
      secondary: [],
      aliases: ['Machine Calf Raise'],
    ),
    _exercise(
      id: 'ex-049',
      name: 'Reverse Fly',
      equipment: 'Dumbbell',
      pattern: 'pull', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Posterior Delt'],
      secondary: ['Rhomboids/Mid Traps'],
      aliases: ['Rear Delt Fly', 'Bent Over Fly'],
    ),
    _exercise(
      id: 'ex-050',
      name: 'Plank',
      equipment: 'Bodyweight',
      pattern: 'push', angle: 'flat', laterality: 'bilateral',
      loading: 'peripheral', cns: 'low', skill: 'beginner', mechanics: 'isolation',
      primary: ['Transverse Abdominis', 'Rectus Abdominis'],
      secondary: ['Obliques', 'Erectors'],
      aliases: ['Front Plank', 'Prone Hold'],
    ),
  ];

  // ─────────── Helper to construct exercise seed records ───────────

  static Map<String, dynamic> _exercise({
    required String id,
    required String name,
    required String equipment,
    required String pattern,
    required String angle,
    required String laterality,
    required String loading,
    required String cns,
    required String skill,
    required String mechanics,
    required List<String> primary,
    required List<String> secondary,
    List<String> aliases = const [],
  }) {
    return {
      'exercise': {
        'id': id,
        'name': name,
        'equipment_id': _eq[equipment],
        'primary_muscle': _mr[primary.first],
        'movement_pattern': pattern,
        'angle': angle,
        'laterality': laterality,
        'loading_type': loading,
        'cns_cost': cns,
        'skill_level': skill,
        'mechanics': mechanics,
        'tier': 1,
        'confidence': 1.0,
        'canonical_hash': null,
        'created_by': null,
        'created_at': '2026-04-09T00:00:00Z',
        'updated_at': '2026-04-09T00:00:00Z',
      },
      'muscles': [
        ...primary.map((m) => {'muscle_id': _mr[m], 'role': 'primary'}),
        ...secondary.map((m) => {'muscle_id': _mr[m], 'role': 'secondary'}),
      ],
      'aliases': [
        name, // canonical name is always the first alias
        ...aliases,
      ],
    };
  }
}
