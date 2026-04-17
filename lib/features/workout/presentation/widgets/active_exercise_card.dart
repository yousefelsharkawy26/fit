/// active_exercise_card.dart
///
/// Extracted, self-contained exercise card for Gym Mode.
/// Owns its own [TextEditingController] lifecycle (Controller-Factory pattern)
/// and uses [RepaintBoundary] to isolate repaints from the parent list.
///
/// Features:
///  - Polymorphic tracking fields (weight/reps vs distance/time/HR)
///  - Tactile steppers with [HapticFeedback.lightImpact]
///  - Swipe-to-delete sets with [Dismissible] + [HapticFeedback.heavyImpact]
///  - 1-tap set logging with [HapticFeedback.mediumImpact]
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fit/features/common/design_tokens.dart';
import 'package:fit/features/workout/domain/models/set_log_payload.dart';
import 'package:fit/features/workout/presentation/providers/workout_providers.dart';
import 'package:fit/features/workout/presentation/widgets/workout_ui_patterns.dart';
import 'package:fit/features/workout/presentation/widgets/glassmorphic_sheet.dart';
import 'package:fit/features/workout/presentation/widgets/form_coach_modal.dart';
import 'package:fit/features/ontology/presentation/providers/substitution_providers.dart';
import 'package:fit/features/ontology/presentation/widgets/substitution_sheet.dart';
import 'package:fit/features/ontology/data/database/database.dart';
import 'package:fit/features/workout/presentation/widgets/predictive_prescription_card.dart';

/// A single exercise card inside the Gym Mode workout list.
///
/// Wrapped by [RepaintBoundary] at the call-site so repaints from logging
/// sets, editing controllers, or expanding overflow fields do NOT trigger
/// a full-list repaint.
class ActiveExerciseCard extends ConsumerStatefulWidget {
  final SessionExercise sessionExercise;

  const ActiveExerciseCard({
    super.key,
    required this.sessionExercise,
  });

  @override
  ConsumerState<ActiveExerciseCard> createState() =>
      _ActiveExerciseCardState();
}

class _ActiveExerciseCardState extends ConsumerState<ActiveExerciseCard> {
  // ---- Controller-Factory: Owned entirely by this widget ----
  final Map<TrackingField, TextEditingController> _controllers = {};

  SessionExercise get se => widget.sessionExercise;

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _controller(TrackingField field) {
    return _controllers.putIfAbsent(field, () {
      final initial = switch (field) {
        TrackingField.weight => se.target.weight.toString(),
        TrackingField.reps => se.target.reps.toString(),
        TrackingField.distance => '1000',
        TrackingField.duration => '00:05:00',
        TrackingField.heartRate => '',
      };
      return TextEditingController(text: initial);
    });
  }

  // ---- Field ordering ----
  List<TrackingField> get _orderedFields {
    final required = requiredFieldsForScheme(se.trackingScheme);
    const order = [
      TrackingField.weight,
      TrackingField.reps,
      TrackingField.distance,
      TrackingField.duration,
      TrackingField.heartRate,
    ];
    return order.where(required.contains).toList();
  }

  TrackingField? get _primaryField =>
      _orderedFields.isEmpty ? null : _orderedFields.first;

  TrackingField? get _secondaryField =>
      _orderedFields.length > 1 ? _orderedFields[1] : null;

  List<TrackingField> get _overflowFields =>
      _orderedFields.length > 2 ? _orderedFields.sublist(2) : [];

  // ---- Build ----

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: FitColors.cardFill,
        borderRadius: BorderRadius.circular(FitRadii.card),
        border: Border.all(color: FitColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 4),
          _buildAITarget(),
          const SizedBox(height: 4),
          _buildTrackingBadge(),
          const SizedBox(height: 8),
          _buildMetaPills(),
          if (se.exercise.notes != null &&
              se.exercise.notes!.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildNotesBanner(),
          ],
          const SizedBox(height: 20),
          _buildSetsHeader(),
          const SizedBox(height: 8),
          // Logged sets — Dismissible swipe-to-delete
          ...se.sets.asMap().entries.map((entry) => _buildLoggedSetRow(
                index: entry.key + 1,
                set: entry.value,
              )),
          const SizedBox(height: 8),
          // Ready-to-log row
          _buildInputSetRow(),
        ],
      ),
    );
  }

  // ---- Actions ----
  void _onOpenFormCoach() {
    if (se.ontologyNode == null) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FormCoachModal(exercise: se.ontologyNode!),
    );
  }

  // ---- Header ----

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            se.name,
            style: const TextStyle(
              color: FitColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: FitColors.cyberCyanMuted,
            borderRadius: BorderRadius.circular(FitRadii.input),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (se.ontologyNode != null)
                IconButton(
                  icon: const Icon(
                    Icons.smart_display_rounded,
                    color: FitColors.cyberCyan,
                  ),
                  tooltip: 'Form Coach',
                  onPressed: _onOpenFormCoach,
                ),
              IconButton(
                icon: const Icon(
                  Icons.swap_horiz_rounded,
                  color: FitColors.cyberCyan,
                ),
                tooltip: 'Swap exercise',
                onPressed: _onSwapExercise,
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: FitColors.signalRed,
                ),
                tooltip: 'Remove exercise',
                onPressed: _onRemoveExercise,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAITarget() {
    return PredictivePrescriptionCard(exerciseId: se.exercise.exerciseId);
  }

  Widget _buildTrackingBadge() {
    return Text(
      'TRACKING: ${trackingSchemeLabel(se.trackingScheme)}',
      style: const TextStyle(
        color: FitColors.signalGreen,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildMetaPills() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _MetaPill(
          icon: Icons.track_changes_outlined,
          text: trackingSchemeLabel(se.trackingScheme),
        ),
        _MetaPill(
          icon: Icons.playlist_add_check_rounded,
          text: '${se.sets.length} sets logged',
        ),
      ],
    );
  }

  Widget _buildNotesBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: FitColors.signalAmber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(FitRadii.stepper),
        border: Border.all(
          color: FitColors.signalAmber.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.info_outline,
            color: FitColors.signalAmber,
            size: 14,
          ),
          const SizedBox(width: 8),
          Text(
            se.exercise.notes!,
            style: const TextStyle(
              color: FitColors.signalAmber,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ---- Sets ----

  Widget _buildSetsHeader() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'SET',
            style: TextStyle(color: FitColors.textTertiary, fontSize: 10),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            _fieldLabel(_primaryField),
            style: TextStyle(color: FitColors.textTertiary, fontSize: 10),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            _fieldLabel(_secondaryField),
            style: TextStyle(color: FitColors.textTertiary, fontSize: 10),
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildLoggedSetRow({
    required int index,
    required WorkoutSet set,
  }) {
    return Dismissible(
      key: ValueKey('set-${set.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: FitColors.signalRed.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.delete_outline_rounded,
          color: FitColors.signalRed,
        ),
      ),
      confirmDismiss: (_) => _confirmDestructive(
        title: 'Delete set?',
        message: 'This logged set will be permanently removed.',
      ),
      onDismissed: (_) {
        HapticFeedback.heavyImpact();
        ref.read(workoutSessionProvider.notifier).removeSet(
              workoutExerciseId: se.exercise.id,
              setId: set.id,
            );
      },
      child: _SetRowDisplay(
        index: index,
        primaryField: _primaryField,
        secondaryField: _secondaryField,
        primaryValue: _valueForField(set, _primaryField),
        secondaryValue: _valueForField(set, _secondaryField),
        overflowFields: _overflowFields,
        hasOverflowData: _overflowFields
            .any((f) => _valueForField(set, f) != null),
        onOverflowTap: () => _showOverflowSheet(
          isDone: true,
          setToDisplay: set,
        ),
      ),
    );
  }

  Widget _buildInputSetRow() {
    return _SetRowInput(
      index: se.sets.length + 1,
      primaryField: _primaryField,
      secondaryField: _secondaryField,
      primaryController:
          _primaryField != null ? _controller(_primaryField!) : null,
      secondaryController:
          _secondaryField != null ? _controller(_secondaryField!) : null,
      overflowFields: _overflowFields,
      hasOverflowData: _overflowFields.any((f) {
        final c = _controllers[f];
        return c != null && c.text.isNotEmpty;
      }),
      onOverflowTap: () => _showOverflowSheet(isDone: false),
      onLog: _onLogSet,
    );
  }

  // ---- Actions ----

  void _onLogSet() {
    HapticFeedback.mediumImpact();
    final payload = SetLogPayload(
      scheme: se.trackingScheme,
      weight: double.tryParse(
          _controllers[TrackingField.weight]?.text ?? ''),
      reps:
          int.tryParse(_controllers[TrackingField.reps]?.text ?? ''),
      distance: double.tryParse(
          _controllers[TrackingField.distance]?.text ?? ''),
      duration: _parseHhMmSs(
          _controllers[TrackingField.duration]?.text ?? ''),
      heartRate: int.tryParse(
          _controllers[TrackingField.heartRate]?.text ?? ''),
    );
    ref
        .read(workoutSessionProvider.notifier)
        .logSet(se.exercise.id, payload);
  }

  Future<void> _onSwapExercise() async {
    final db = ref.read(appDatabaseProvider);
    final baseExercise = await db.exerciseDao.getExerciseById(
      se.exercise.exerciseId,
    );
    if (!mounted || baseExercise == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SubstitutionSheet(
        sourceExerciseId: baseExercise.id,
        onExerciseSelected: (newExercise) {
          ref.read(workoutSessionProvider.notifier).swapExercise(
                workoutExerciseId: se.exercise.id,
                newExerciseId: newExercise.id,
              );
        },
      ),
    );
  }

  Future<void> _onRemoveExercise() async {
    final confirmed = await _confirmDestructive(
      title: 'Remove exercise?',
      message: 'All sets logged for this exercise will be deleted.',
    );
    if (!confirmed) return;
    HapticFeedback.heavyImpact();
    await ref
        .read(workoutSessionProvider.notifier)
        .removeExercise(se.exercise.id);
  }

  void _showOverflowSheet({
    required bool isDone,
    WorkoutSet? setToDisplay,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GlassmorphicSheet(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ADDITIONAL DETAILS',
                style: TextStyle(
                  color: FitColors.cyberCyan,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              ..._overflowFields.map((field) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            _fieldLabel(field),
                            style: TextStyle(
                              color: FitColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isDone
                                  ? Colors.black26
                                  : FitColors.cyberCyanMuted,
                              borderRadius:
                                  BorderRadius.circular(FitRadii.input),
                            ),
                            child: isDone
                                ? Text(
                                    _displayValue(
                                      field,
                                      setToDisplay != null
                                          ? _valueForField(
                                              setToDisplay, field)
                                          : null,
                                    ),
                                    style: const TextStyle(
                                      color: FitColors.textPrimary,
                                    ),
                                  )
                                : _InputControl(
                                    field: field,
                                    controller: _controller(field),
                                    onStep: (dir) =>
                                        _stepField(field, dir),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: WorkoutPrimaryAction(
                  label: 'DONE',
                  icon: Icons.check,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmDestructive({
    required String title,
    required String message,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: FitColors.signalRed,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // ---- Helpers ----

  void _stepField(TrackingField field, int direction) {
    HapticFeedback.lightImpact();
    final controller = _controller(field);
    final current = double.tryParse(controller.text) ?? 0;
    final step = field == TrackingField.weight ? 2.5 : 1.0;
    final next = (current + step * direction).clamp(0, 99999);
    if (field == TrackingField.weight ||
        field == TrackingField.distance) {
      controller.text = next % 1 == 0
          ? next.toInt().toString()
          : next.toStringAsFixed(1);
    } else {
      controller.text = next.toInt().toString();
    }
  }

  static String _fieldLabel(TrackingField? field) => switch (field) {
        TrackingField.weight => 'WEIGHT',
        TrackingField.reps => 'REPS',
        TrackingField.distance => 'DISTANCE',
        TrackingField.duration => 'TIME',
        TrackingField.heartRate => 'HR',
        null => '-',
      };

  static String? _fieldUnit(TrackingField? field) => switch (field) {
        TrackingField.weight => 'kg',
        TrackingField.distance => 'm',
        TrackingField.duration => 's',
        TrackingField.heartRate => 'bpm',
        _ => null,
      };

  static String _displayValue(TrackingField? field, String? raw) {
    if (field == null) return '-';
    if (field == TrackingField.duration) {
      final seconds = int.tryParse(raw ?? '0') ?? 0;
      return _formatSeconds(seconds);
    }
    return '${raw ?? '0'}${_fieldUnit(field) ?? ''}';
  }

  static String? _valueForField(WorkoutSet set, TrackingField? field) {
    if (field == null) return null;
    return switch (field) {
      TrackingField.weight => set.weight.toString(),
      TrackingField.reps => set.reps.toString(),
      TrackingField.distance => set.distance?.toString(),
      TrackingField.duration => set.duration?.toString(),
      TrackingField.heartRate => set.heartRate?.toString(),
    };
  }

  static String _formatSeconds(int seconds) {
    final h = (seconds ~/ 3600).toString().padLeft(2, '0');
    final m = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  static int? _parseHhMmSs(String text) {
    final parts = text.split(':');
    if (parts.length != 3) return int.tryParse(text);
    final h = int.tryParse(parts[0]) ?? 0;
    final m = int.tryParse(parts[1]) ?? 0;
    final s = int.tryParse(parts[2]) ?? 0;
    return h * 3600 + m * 60 + s;
  }
}

// ---------------------------------------------------------------------------
// Sub-Widgets (private, leaf-level for optimal rebuild isolation)
// ---------------------------------------------------------------------------

/// A read-only set row for logged (completed) sets.
class _SetRowDisplay extends StatelessWidget {
  final int index;
  final TrackingField? primaryField;
  final TrackingField? secondaryField;
  final String? primaryValue;
  final String? secondaryValue;
  final List<TrackingField> overflowFields;
  final bool hasOverflowData;
  final VoidCallback onOverflowTap;

  const _SetRowDisplay({
    required this.index,
    required this.primaryField,
    required this.secondaryField,
    required this.primaryValue,
    required this.secondaryValue,
    required this.overflowFields,
    required this.hasOverflowData,
    required this.onOverflowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$index',
              style: const TextStyle(
                color: FitColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: _ValueCell(
              value: _ActiveExerciseCardState._displayValue(
                primaryField,
                primaryValue,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: _ValueCell(
              value: _ActiveExerciseCardState._displayValue(
                secondaryField,
                secondaryValue,
              ),
            ),
          ),
          if (overflowFields.isNotEmpty) ...[
            _OverflowButton(
              hasData: hasOverflowData,
              onTap: onOverflowTap,
            ),
            const SizedBox(width: 8),
          ],
          _CheckIcon(isDone: true),
        ],
      ),
    );
  }
}

/// An editable set row with stepper inputs for the next set to log.
class _SetRowInput extends StatelessWidget {
  final int index;
  final TrackingField? primaryField;
  final TrackingField? secondaryField;
  final TextEditingController? primaryController;
  final TextEditingController? secondaryController;
  final List<TrackingField> overflowFields;
  final bool hasOverflowData;
  final VoidCallback onOverflowTap;
  final VoidCallback onLog;

  const _SetRowInput({
    required this.index,
    required this.primaryField,
    required this.secondaryField,
    required this.primaryController,
    required this.secondaryController,
    required this.overflowFields,
    required this.hasOverflowData,
    required this.onOverflowTap,
    required this.onLog,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$index',
              style: const TextStyle(
                color: FitColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: FitColors.cyberCyanMuted,
                borderRadius: BorderRadius.circular(FitRadii.input),
              ),
              child: primaryField != null && primaryController != null
                  ? _InputControl(
                      field: primaryField!,
                      controller: primaryController!,
                    )
                  : Text('-',
                      style: TextStyle(color: FitColors.textTertiary)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: FitColors.cyberCyanMuted,
                borderRadius: BorderRadius.circular(FitRadii.input),
              ),
              child: secondaryField != null && secondaryController != null
                  ? _InputControl(
                      field: secondaryField!,
                      controller: secondaryController!,
                    )
                  : Text('-',
                      style: TextStyle(color: FitColors.textTertiary)),
            ),
          ),
          const SizedBox(width: 12),
          if (overflowFields.isNotEmpty) ...[
            _OverflowButton(
              hasData: hasOverflowData,
              onTap: onOverflowTap,
            ),
            const SizedBox(width: 8),
          ],
          GestureDetector(
            onTap: onLog,
            child: _CheckIcon(isDone: false),
          ),
        ],
      ),
    );
  }
}

/// Numeric input with +/- stepper buttons and haptic feedback.
class _InputControl extends StatelessWidget {
  final TrackingField field;
  final TextEditingController controller;
  final void Function(int direction)? onStep;

  const _InputControl({
    required this.field,
    required this.controller,
    this.onStep,
  });

  @override
  Widget build(BuildContext context) {
    if (field == TrackingField.duration) {
      return InkWell(
        borderRadius: BorderRadius.circular(FitRadii.stepper),
        onTap: () => _openDurationEditor(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            controller.text,
            style: const TextStyle(
              color: FitColors.cyberCyan,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        _StepperButton(
          icon: Icons.remove,
          onTap: () {
            HapticFeedback.lightImpact();
            if (onStep != null) {
              onStep!(-1);
            } else {
              _defaultStep(-1);
            }
          },
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: field == TrackingField.weight ||
                    field == TrackingField.distance
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.number,
            style: const TextStyle(
              color: FitColors.cyberCyan,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              suffixText: _ActiveExerciseCardState._fieldUnit(field),
              suffixStyle: TextStyle(
                color: FitColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _StepperButton(
          icon: Icons.add,
          onTap: () {
            HapticFeedback.lightImpact();
            if (onStep != null) {
              onStep!(1);
            } else {
              _defaultStep(1);
            }
          },
        ),
      ],
    );
  }

  void _defaultStep(int direction) {
    final current = double.tryParse(controller.text) ?? 0;
    final step = field == TrackingField.weight ? 2.5 : 1.0;
    final next = (current + step * direction).clamp(0, 99999);
    if (field == TrackingField.weight ||
        field == TrackingField.distance) {
      controller.text = next % 1 == 0
          ? next.toInt().toString()
          : next.toStringAsFixed(1);
    } else {
      controller.text = next.toInt().toString();
    }
  }

  Future<void> _openDurationEditor(BuildContext context) async {
    final current =
        _ActiveExerciseCardState._parseHhMmSs(controller.text) ?? 0;
    final h =
        TextEditingController(text: (current ~/ 3600).toString());
    final m = TextEditingController(
        text: ((current % 3600) ~/ 60).toString());
    final s =
        TextEditingController(text: (current % 60).toString());

    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Duration (HH:MM:SS)'),
        content: Row(
          children: [
            Expanded(
              child: TextField(
                controller: h,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'HH'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: m,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'MM'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: s,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'SS'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Apply'),
          ),
        ],
      ),
    );

    if (ok != true) return;
    final total = ((int.tryParse(h.text) ?? 0) * 3600) +
        ((int.tryParse(m.text) ?? 0) * 60) +
        (int.tryParse(s.text) ?? 0);
    controller.text = _ActiveExerciseCardState._formatSeconds(total);
  }
}

// ---------------------------------------------------------------------------
// Shared leaf widgets
// ---------------------------------------------------------------------------

class _ValueCell extends StatelessWidget {
  final String value;
  const _ValueCell({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(FitRadii.input),
      ),
      child: Text(value, style: const TextStyle(color: FitColors.textPrimary)),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _StepperButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: FitColors.cyberCyanMuted,
      borderRadius: BorderRadius.circular(FitRadii.stepper),
      child: InkWell(
        borderRadius: BorderRadius.circular(FitRadii.stepper),
        onTap: onTap,
        child: SizedBox(
          width: 32,
          height: 32,
          child: Icon(icon, color: FitColors.cyberCyan, size: 18),
        ),
      ),
    );
  }
}

class _OverflowButton extends StatelessWidget {
  final bool hasData;
  final VoidCallback onTap;
  const _OverflowButton({required this.hasData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: hasData
              ? FitColors.cyberCyan.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: hasData
              ? Border.all(
                  color: FitColors.cyberCyan.withValues(alpha: 0.5))
              : null,
        ),
        child: Icon(
          Icons.more_horiz_rounded,
          color: hasData ? FitColors.cyberCyan : FitColors.textSecondary,
          size: 20,
        ),
      ),
    );
  }
}

class _CheckIcon extends StatelessWidget {
  final bool isDone;
  const _CheckIcon({required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isDone
            ? FitColors.signalGreen
            : Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        isDone ? Icons.check : Icons.add_rounded,
        color: isDone ? Colors.black : FitColors.textTertiary,
        size: 20,
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  final IconData icon;
  final String text;
  const _MetaPill({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(FitRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: FitColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: FitColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
