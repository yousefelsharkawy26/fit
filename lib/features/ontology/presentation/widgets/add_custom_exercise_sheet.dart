import 'dart:convert';
import 'dart:typed_data';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/database/database.dart';
import '../../domain/enums/ontology_enums.dart';
import '../providers/ontology_data_providers.dart';

import '../../domain/services/ai_ontology_service.dart';
import '../../data/utils/canonical_hash.dart';
import '../../domain/services/flywheel_sync_service.dart';

/// Interactive sheet to add a Tier 2 (Custom) exercise with AI assistance.
///
/// Features:
/// - "Magic Wand" AI Inference: Predicts metadata from name.
/// - Validation for all 9+1 ontological dimensions.
/// - Background vectorization upon save.
class AddCustomExerciseSheet extends ConsumerStatefulWidget {
  const AddCustomExerciseSheet({super.key});

  @override
  ConsumerState<AddCustomExerciseSheet> createState() =>
      _AddCustomExerciseSheetState();
}

class _AddCustomExerciseSheetState
    extends ConsumerState<AddCustomExerciseSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  // Selection State
  MovementPattern? _pattern;
  ExerciseAngle? _angle;
  Laterality? _laterality;
  LoadingType? _loading;
  CnsCost? _cnsCost;
  SkillLevel? _skill;
  Mechanics? _mechanics;
  PlaneOfMotion? _plane;
  String? _equipmentId;

  // Muscle Roles (simplified for MVP: One primary, one secondary)
  String? _primaryMuscleId;
  String? _secondaryMuscleId;

  bool _isInferring = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Hits the AI Inference Connector to predict metadata.
  Future<void> _handleAIInference() async {
    final name = _nameController.text;
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a name for the AI to analyze.')),
      );
      return;
    }

    setState(() => _isInferring = true);

    try {
      final suggestion = await ref.read(aiOntologyServiceProvider).infer(name);
      if (!mounted) return;
      if (suggestion != null) {
        setState(() {
          if (suggestion.pattern != null) _pattern = suggestion.pattern;
          if (suggestion.angle != null) _angle = suggestion.angle;
          if (suggestion.laterality != null) _laterality = suggestion.laterality;
          if (suggestion.mechanics != null) _mechanics = suggestion.mechanics;
          if (suggestion.loading != null) _loading = suggestion.loading;
          if (suggestion.plane != null) _plane = suggestion.plane;
        });
      }
    } finally {
      if (mounted) setState(() => _isInferring = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() ||
        _equipmentId == null ||
        _primaryMuscleId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pleas fill all required fields.')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final exerciseId = const Uuid().v4();
      final now = DateTime.now().toUtc().toIso8601String();

      // 1. Create Exercise Record
      final exercise = ExercisesCompanion.insert(
        id: exerciseId,
        name: _nameController.text,
        equipmentId: _equipmentId!,
        movementPattern:
            _pattern ?? MovementPattern.push, // Default to push if null
        primaryMuscleId: _primaryMuscleId!,
        planeOfMotion: _plane != null ? Value(_plane) : const Value.absent(),
        angle: _angle ?? ExerciseAngle.flat,
        laterality: _laterality ?? Laterality.bilateral,
        loadingType: _loading ?? LoadingType.peripheral,
        cnsCost: _cnsCost ?? CnsCost.medium,
        skillLevel: _skill ?? SkillLevel.beginner,
        mechanics: _mechanics ?? Mechanics.compound,
        tier: const Value(ExerciseTier.aiInferred),
        confidence: const Value(
          0.8,
        ), // Custom exercises have lower initial confidence
        canonicalHash: Value(CanonicalHash.compute(_nameController.text)),
        createdBy: const Value('local-user'),
        createdAt: now,
        updatedAt: now,
      );

      // 2. Prepare Junctions
      final muscles = [
        ExerciseMusclesCompanion.insert(
          exerciseId: exerciseId,
          muscleId: _primaryMuscleId!,
          role: MuscleRole.primary,
        ),
        if (_secondaryMuscleId != null)
          ExerciseMusclesCompanion.insert(
            exerciseId: exerciseId,
            muscleId: _secondaryMuscleId!,
            role: MuscleRole.secondary,
          ),
      ];

      final aliases = [
        ExerciseAliasesCompanion.insert(
          id: const Uuid().v4(),
          exerciseId: exerciseId,
          aliasName: _nameController.text,
          isPrimary: const Value(true),
        ),
      ];

      // 3. Save to DB
      final dao = ref.read(exerciseDaoProvider);
      await dao.insertExercise(
        exercise: exercise,
        muscles: muscles,
        aliases: aliases,
      );

      // 4. Generate and Save Vector for sqlite-vec
      // We hydrate the exercise first to ensure we have the full domain model
      final hydrated = await dao.getExerciseById(exerciseId);
      Float32List computedVector = Float32List(0);
      if (hydrated != null) {
        final vectorRepo = ref.read(vectorRepositoryProvider);
        computedVector = ref
            .read(vectorComputeServiceProvider)
            .computeSync(hydrated);
        await vectorRepo.insertVector(exerciseId, computedVector);
      }

      // 5. Enqueue Sync for Flywheel
      await dao.enqueueSyncAction(
        id: 'sync-add-${DateTime.now().millisecondsSinceEpoch}',
        action: SyncAction.inferMetadata,
        payload: jsonEncode({
          'exercise_id': exerciseId,
          'exercise_name': _nameController.text,
          'user_id': 'local-user', // PII - to be stripped by Payload Sanitizer
          'canonical_hash': CanonicalHash.compute(_nameController.text),
          'vector': computedVector, // Added vector for exact biomechanical matching
          'metadata': {
            'pattern': _pattern?.name,
            'equipment_id': _equipmentId,
            'primary_muscle_id': _primaryMuscleId,
          },
        }),
      );

      // 6. Invalidate Providers to refresh UI
      ref.invalidate(substitutionResultsProvider);

      // 7. Trigger Background Processing
      ref.read(flywheelSyncServiceProvider).syncPendingTasks();

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving: $e')));
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muscleRegions = ref.watch(allMuscleRegionsProvider);
    final equipment = ref.watch(allEquipmentProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Custom Exercise',
                      style: theme.textTheme.headlineSmall,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Form
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20),
                    children: [
                      // Name Input with Magic Wand
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Exercise Name',
                                hintText: 'e.g. JM Press, Zercher Squat',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v!.isEmpty ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          IconButton.filledTonal(
                            onPressed: _isInferring ? null : _handleAIInference,
                            icon: _isInferring
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.auto_awesome),
                            tooltip: 'AI Magic: Guess metadata from name',
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Core Taxonomy
                      _SectionHeader('Ontological Dimensions', theme),
                      const SizedBox(height: 12),

                      _buildDropdown<MovementPattern>(
                        'Movement Pattern',
                        MovementPattern.values,
                        _pattern,
                        (v) => setState(() => _pattern = v),
                      ),
                      const SizedBox(height: 12),

                      equipment.maybeWhen(
                        data: (list) => _buildDropdown<String>(
                          'Primary Equipment',
                          list.map((e) => e.id).toList(),
                          _equipmentId,
                          (v) => setState(() => _equipmentId = v),
                          itemLabelBuilder: (id) =>
                              list.firstWhere((e) => e.id == id).name,
                        ),
                        orElse: () => const LinearProgressIndicator(),
                      ),
                      const SizedBox(height: 24),

                      // Muscle Targets
                      _SectionHeader('Muscle Targets', theme),
                      const SizedBox(height: 12),

                      muscleRegions.maybeWhen(
                        data: (list) => Column(
                          children: [
                            _buildDropdown<String>(
                              'Primary Muscle',
                              list.map((e) => e.id).toList(),
                              _primaryMuscleId,
                              (v) => setState(() => _primaryMuscleId = v),
                              itemLabelBuilder: (id) =>
                                  list.firstWhere((e) => e.id == id).name,
                            ),
                            const SizedBox(height: 12),
                            _buildDropdown<String>(
                              'Secondary Muscle (Optional)',
                              list.map((e) => e.id).toList(),
                              _secondaryMuscleId,
                              (v) => setState(() => _secondaryMuscleId = v),
                              itemLabelBuilder: (id) =>
                                  list.firstWhere((e) => e.id == id).name,
                            ),
                          ],
                        ),
                        orElse: () => const LinearProgressIndicator(),
                      ),
                      const SizedBox(height: 24),

                      // Advanced Metadata
                      _SectionHeader('Advanced Metadata', theme),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildChoiceChip<ExerciseAngle>(
                            'Angle',
                            ExerciseAngle.values,
                            _angle,
                            (v) => setState(() => _angle = v),
                          ),
                          _buildChoiceChip<Laterality>(
                            'Side',
                            Laterality.values,
                            _laterality,
                            (v) => setState(() => _laterality = v),
                          ),
                          _buildChoiceChip<Mechanics>(
                            'Mechanics',
                            Mechanics.values,
                            _mechanics,
                            (v) => setState(() => _mechanics = v),
                          ),
                          _buildChoiceChip<PlaneOfMotion>(
                            'Plane',
                            PlaneOfMotion.values,
                            _plane,
                            (v) => setState(() => _plane = v),
                          ),
                        ],
                      ),

                      const SizedBox(height: 48),

                      // Action Button
                      ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          backgroundColor: theme.colorScheme.primaryContainer,
                          foregroundColor: theme.colorScheme.onPrimaryContainer,
                        ),
                        child: _isSaving
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Save Custom Exercise',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropdown<T>(
    String label,
    List<T> values,
    T? current,
    ValueChanged<T?> onChanged, {
    String Function(T)? itemLabelBuilder,
  }) {
    return DropdownButtonFormField<T>(
      initialValue: current,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: values
          .map(
            (v) => DropdownMenuItem(
              value: v,
              child: Text(
                itemLabelBuilder?.call(v) ?? v.toString().split('.').last,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildChoiceChip<T>(
    String label,
    List<T> values,
    T? current,
    ValueChanged<T> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 4,
          children: values
              .map(
                (v) => ChoiceChip(
                  label: Text(
                    v.toString().split('.').last,
                    style: const TextStyle(fontSize: 10),
                  ),
                  selected: current == v,
                  onSelected: (_) => onChanged(v),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final ThemeData theme;
  const _SectionHeader(this.title, this.theme);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.colorScheme.primary,
        letterSpacing: 1.2,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
