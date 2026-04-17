/// Seed data for the ~25 muscle regions — the "Goldilocks" taxonomy.
///
/// Organized by muscle group for UI display, with stable UUIDs
/// that are consistent across all devices and app versions.
///
/// See: exercise_ontology_design.md §3 — Muscle Region Taxonomy
library;

class MuscleRegionSeed {
  MuscleRegionSeed._();

  /// All 25 muscle regions with stable UUIDs.
  static const List<Map<String, dynamic>> data = [
    // ── Chest (3 regions) ──
    {
      'id': 'mr-001-upper-chest',
      'name': 'Upper Chest',
      'muscle_group': 'Chest',
      'display_order': 1,
    },
    {
      'id': 'mr-002-mid-chest',
      'name': 'Mid Chest',
      'muscle_group': 'Chest',
      'display_order': 2,
    },
    {
      'id': 'mr-003-lower-chest',
      'name': 'Lower Chest',
      'muscle_group': 'Chest',
      'display_order': 3,
    },

    // ── Back (4 regions) ──
    {
      'id': 'mr-004-upper-lats',
      'name': 'Upper Lats',
      'muscle_group': 'Back',
      'display_order': 4,
    },
    {
      'id': 'mr-005-lower-lats',
      'name': 'Lower Lats',
      'muscle_group': 'Back',
      'display_order': 5,
    },
    {
      'id': 'mr-006-rhomboids-mid-traps',
      'name': 'Rhomboids/Mid Traps',
      'muscle_group': 'Back',
      'display_order': 6,
    },
    {
      'id': 'mr-007-erectors',
      'name': 'Erectors',
      'muscle_group': 'Back',
      'display_order': 7,
    },

    // ── Shoulders (3 regions) ──
    {
      'id': 'mr-008-anterior-delt',
      'name': 'Anterior Delt',
      'muscle_group': 'Shoulders',
      'display_order': 8,
    },
    {
      'id': 'mr-009-lateral-delt',
      'name': 'Lateral Delt',
      'muscle_group': 'Shoulders',
      'display_order': 9,
    },
    {
      'id': 'mr-010-posterior-delt',
      'name': 'Posterior Delt',
      'muscle_group': 'Shoulders',
      'display_order': 10,
    },

    // ── Arms — Biceps (2 regions) ──
    {
      'id': 'mr-011-biceps-long-head',
      'name': 'Biceps (Long Head)',
      'muscle_group': 'Arms',
      'display_order': 11,
    },
    {
      'id': 'mr-012-biceps-short-head',
      'name': 'Biceps (Short Head)',
      'muscle_group': 'Arms',
      'display_order': 12,
    },

    // ── Arms — Triceps (2 regions) ──
    {
      'id': 'mr-013-triceps-long-head',
      'name': 'Triceps (Long Head)',
      'muscle_group': 'Arms',
      'display_order': 13,
    },
    {
      'id': 'mr-014-triceps-medial-lateral',
      'name': 'Triceps (Medial/Lateral)',
      'muscle_group': 'Arms',
      'display_order': 14,
    },

    // ── Arms — Forearms (1 region) ──
    {
      'id': 'mr-015-forearms',
      'name': 'Forearms',
      'muscle_group': 'Arms',
      'display_order': 15,
    },

    // ── Legs — Quads (2 regions) ──
    {
      'id': 'mr-016-quads-rf-bias',
      'name': 'Quads (Rectus Femoris bias)',
      'muscle_group': 'Legs',
      'display_order': 16,
    },
    {
      'id': 'mr-017-quads-vmo-bias',
      'name': 'Quads (VMO bias)',
      'muscle_group': 'Legs',
      'display_order': 17,
    },

    // ── Legs — Hamstrings (1 region) ──
    {
      'id': 'mr-018-hamstrings',
      'name': 'Hamstrings',
      'muscle_group': 'Legs',
      'display_order': 18,
    },

    // ── Legs — Glutes (2 regions) ──
    {
      'id': 'mr-019-glutes-max',
      'name': 'Glutes (Max)',
      'muscle_group': 'Legs',
      'display_order': 19,
    },
    {
      'id': 'mr-020-glutes-med-min',
      'name': 'Glutes (Med/Min)',
      'muscle_group': 'Legs',
      'display_order': 20,
    },

    // ── Legs — Calves (1 region) ──
    {
      'id': 'mr-021-calves',
      'name': 'Calves',
      'muscle_group': 'Legs',
      'display_order': 21,
    },

    // ── Core (3 regions) ──
    {
      'id': 'mr-022-rectus-abdominis',
      'name': 'Rectus Abdominis',
      'muscle_group': 'Core',
      'display_order': 22,
    },
    {
      'id': 'mr-023-obliques',
      'name': 'Obliques',
      'muscle_group': 'Core',
      'display_order': 23,
    },
    {
      'id': 'mr-024-transverse-abdominis',
      'name': 'Transverse Abdominis',
      'muscle_group': 'Core',
      'display_order': 24,
    },

    // ── Traps (1 region) ──
    {
      'id': 'mr-025-upper-traps',
      'name': 'Upper Traps',
      'muscle_group': 'Traps',
      'display_order': 25,
    },
  ];

  /// Quick lookup: muscle region name → stable ID.
  static final Map<String, String> nameToId = {
    for (final region in data) region['name'] as String: region['id'] as String,
  };
}
