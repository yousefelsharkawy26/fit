/// Seed data for the equipment catalog.
///
/// Equipment is one of the primary substitution triggers
/// ("Squat rack taken" → filter by equipment).
///
/// See: exercise_ontology_design.md §3
library;

class EquipmentSeed {
  EquipmentSeed._();

  /// All 8 equipment types with stable IDs.
  static const List<Map<String, dynamic>> data = [
    {
      'id': 'eq-001-barbell',
      'name': 'Barbell',
      'icon': 'barbell',
    },
    {
      'id': 'eq-002-dumbbell',
      'name': 'Dumbbell',
      'icon': 'dumbbell',
    },
    {
      'id': 'eq-003-cable',
      'name': 'Cable',
      'icon': 'cable',
    },
    {
      'id': 'eq-004-machine',
      'name': 'Machine',
      'icon': 'machine',
    },
    {
      'id': 'eq-005-bodyweight',
      'name': 'Bodyweight',
      'icon': 'bodyweight',
    },
    {
      'id': 'eq-006-kettlebell',
      'name': 'Kettlebell',
      'icon': 'kettlebell',
    },
    {
      'id': 'eq-007-band',
      'name': 'Band',
      'icon': 'band',
    },
    {
      'id': 'eq-008-other',
      'name': 'Other',
      'icon': 'other',
    },
  ];

  /// Quick lookup: equipment name → stable ID.
  static final Map<String, String> nameToId = {
    for (final eq in data) eq['name'] as String: eq['id'] as String,
  };
}
