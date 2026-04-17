/// gym_mode_screen.dart
///
/// Kinetic Precision V2 — Gym Mode Orchestrator.
///
/// This screen is the conductor, NOT the performer. All heavy rendering
/// is delegated to extracted widgets:
///  - [CoachInsightBanner] — AI coaching tip with AnimatedSwitcher
///  - [SessionStatsBar] — Animated exercise/set counters
///  - [ActiveExerciseCard] — Self-contained card with controller lifecycle
///  - [GlassmorphicSheet] — BackdropFilter bottom sheets
///
/// The orchestrator owns:
///  - Session lifecycle (start/finish)
///  - Safety Shield listener (biomechanical pivot warnings)
///  - Exercise picker + tracking scheme picker flows
///  - Navigation/routing between sheets
library;

import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fit/features/common/design_tokens.dart';
import 'package:fit/features/workout/domain/models/set_log_payload.dart';
import 'package:fit/features/workout/presentation/providers/workout_providers.dart';
import 'package:fit/features/workout/presentation/widgets/active_exercise_card.dart';
import 'package:fit/features/workout/presentation/widgets/coach_insight_banner.dart';
import 'package:fit/features/workout/presentation/widgets/session_stats_bar.dart';
import 'package:fit/features/workout/presentation/widgets/glassmorphic_sheet.dart';
import 'package:fit/features/workout/presentation/widgets/workout_ui_patterns.dart';

import 'package:fit/features/health/presentation/widgets/health_status_banner.dart';

import 'package:fit/features/ontology/presentation/widgets/substitution_sheet.dart';
import 'package:fit/features/ontology/presentation/providers/ontology_data_providers.dart';
import 'package:fit/features/ontology/domain/models/ontology_models.dart';
import 'package:fit/features/ontology/domain/enums/ontology_enums.dart';


class GymModeScreen extends ConsumerStatefulWidget {
  const GymModeScreen({super.key});

  @override
  ConsumerState<GymModeScreen> createState() => _GymModeScreenState();
}

class _GymModeScreenState extends ConsumerState<GymModeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(workoutSessionProvider.notifier).startWorkout('local-user');
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(workoutSessionProvider);

    // Listen to Safety Shield Biomechanical Pivot Warnings
    ref.listen(gymWarningStreamProvider, (prev, next) {
      if (next.hasValue && next.value != null) {
        _showCoachTip(next.value!);
      }
    });

    if (session.isLoading) {
      return const Scaffold(
        backgroundColor: FitColors.obsidian,
        body: Center(
          child: CircularProgressIndicator(color: FitColors.cyberCyan),
        ),
      );
    }

    if (session.activeWorkout == null) {
      return _buildFinishedState();
    }

    return Scaffold(
      backgroundColor: FitColors.obsidian,
      appBar: AppBar(
        title:
            _WorkoutHeader(startedAt: session.activeWorkout!.startedAt!),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () =>
                ref.read(workoutSessionProvider.notifier).finishWorkout(),
            child: const Text(
              'FINISH',
              style: TextStyle(
                color: FitColors.cyberCyan,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const CoachInsightBanner(),
              const HealthStatusBanner(),
              SessionStatsBar(
                exerciseCount: session.exercises.length,
                loggedSets: session.exercises.fold<int>(
                  0,
                  (sum, e) => sum + e.sets.length,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: session.exercises.length + 2, // exercises + button + spacer
                  itemBuilder: (context, index) {
                    if (index < session.exercises.length) {
                      return RepaintBoundary(
                        child: ActiveExerciseCard(
                          key: ValueKey(session.exercises[index].exercise.id),
                          sessionExercise: session.exercises[index],
                        ),
                      );
                    }
                    if (index == session.exercises.length) {
                      return _buildAddExerciseButton();
                    }
                    return const SizedBox(height: 120);
                  },
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 30,
            right: 16,
            left: 16,
            child: _RealTimeBiomechanicalHUD(),
          ),
        ],
      ),
    );
  }

  // ---- Finished state ----

  Widget _buildFinishedState() {
    return Scaffold(
      backgroundColor: FitColors.obsidian,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 64,
              color: FitColors.cyberCyan,
            ),
            const SizedBox(height: 16),
            const Text(
              'Workout Finished!',
              style: TextStyle(
                color: FitColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref
                  .read(workoutSessionProvider.notifier)
                  .startWorkout('local-user'),
              style: ElevatedButton.styleFrom(
                backgroundColor: FitColors.cyberCyan,
              ),
              child: const Text(
                'Start New Session',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- Add exercise button ----

  Widget _buildAddExerciseButton() {
    return WorkoutPrimaryAction(
      label: 'ADD EXERCISE',
      icon: Icons.add_rounded,
      onTap: () => _openExercisePicker(),
    );
  }

  // ---- Exercise & scheme pickers ----

  Future<void> _openExercisePicker() async {
    final db = ref.read(appDatabaseProvider);
    final notifier = ref.read(workoutSessionProvider.notifier);
    final exercises = await db.exerciseDao.getAllExercises();
    if (!mounted) return;

    final selectedExercise = await showModalBottomSheet<Exercise>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GlassmorphicSheet(
        maxHeightFraction: 0.80,
        child: _ExercisePickerContent(exercises: exercises),
      ),
    );

    if (selectedExercise == null || !mounted) return;
    final suggested = _suggestScheme(selectedExercise);

    final selectedScheme = await showModalBottomSheet<TrackingScheme>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GlassmorphicSheet(
        maxHeightFraction: 0.75,
        child: _TrackingSchemeContent(suggested: suggested),
      ),
    );

    if (selectedScheme == null) return;
    await notifier.addExercise(
      selectedExercise.id,
      trackingScheme: selectedScheme,
    );
  }

  TrackingScheme _suggestScheme(Exercise exercise) {
    final name = exercise.name.toLowerCase();
    if (name.contains('run') ||
        name.contains('bike') ||
        name.contains('row') ||
        name.contains('walk') ||
        name.contains('cardio')) {
      return TrackingScheme.cardioFull;
    }
    return TrackingScheme.weightReps;
  }

  // ---- Safety Shield (injury warning) ----

  void _showCoachTip(InjuryWarning warning) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: FitColors.signalRed.withAlpha(240),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        duration: const Duration(seconds: 8),
        content: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'BIOMECHANICAL PIVOT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    '${warning.exerciseName} hits injured ${warning.muscleName}.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'SUBSTITUTE',
          textColor: FitColors.cyberCyan,
          onPressed: () {
            final session = ref.read(workoutSessionProvider);
            final workoutEx = session.exercises.firstWhere(
              (e) => e.exercise.exerciseId == warning.exerciseId,
            );
            _performSubstitution(warning, workoutEx.exercise.id);
          },
        ),
      ),
    );
  }

  Future<void> _performSubstitution(
    InjuryWarning warning,
    String workoutExerciseId,
  ) async {
    final db = ref.read(appDatabaseProvider);
    final sourceEx =
        await db.exerciseDao.getExerciseById(warning.exerciseId);
    if (sourceEx == null || !mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SubstitutionSheet(
        sourceExerciseId: sourceEx.id,
        onExerciseSelected: (newExercise) {
          ref.read(workoutSessionProvider.notifier).swapExercise(
                workoutExerciseId: workoutExerciseId,
                newExerciseId: newExercise.id,
              );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Workout Header with Safety Shield Pulse
// ---------------------------------------------------------------------------

class _WorkoutHeader extends ConsumerStatefulWidget {
  final DateTime startedAt;
  const _WorkoutHeader({required this.startedAt});

  @override
  ConsumerState<_WorkoutHeader> createState() => _WorkoutHeaderState();
}

class _WorkoutHeaderState extends ConsumerState<_WorkoutHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: FitDurations.pulse,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: FitCurves.standard),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final constraintsAsync = ref.watch(activeMuscleConstraintsProvider);

    Color shieldColor = FitColors.cyberCyan;
    bool isPulsing = false;

    if (constraintsAsync.hasValue && constraintsAsync.value != null) {
      for (final c in constraintsAsync.value!) {
        if (c.status == MuscleConstraintStatus.injured) {
          shieldColor = FitColors.signalRed;
          isPulsing = true;
          break;
        } else if (c.status == MuscleConstraintStatus.sore) {
          shieldColor = FitColors.signalAmber;
          isPulsing = true;
        }
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GYM FLOOR',
              style: TextStyle(
                fontSize: 12,
                color: FitColors.cyberCyan,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              'ACTIVE SESSION',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: FitColors.textPrimary,
              ),
            ),
          ],
        ),
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: isPulsing
                    ? [
                        BoxShadow(
                          color: shieldColor.withValues(
                            alpha: 0.3 * _pulseAnimation.value,
                          ),
                          spreadRadius: 4 * _pulseAnimation.value,
                          blurRadius: 8 * _pulseAnimation.value,
                        ),
                      ]
                    : [],
              ),
              child: Icon(
                Icons.shield_rounded,
                color: shieldColor,
                size: 28,
              ),
            );
          },
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Exercise Picker (inner content, hosted by GlassmorphicSheet)
// ---------------------------------------------------------------------------

class _ExercisePickerContent extends StatefulWidget {
  final List<Exercise> exercises;
  const _ExercisePickerContent({required this.exercises});

  @override
  State<_ExercisePickerContent> createState() =>
      _ExercisePickerContentState();
}

class _ExercisePickerContentState extends State<_ExercisePickerContent> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.exercises
        .where((e) =>
            e.name.toLowerCase().contains(_query.toLowerCase()) ||
            e.movementPattern.name
                .toLowerCase()
                .contains(_query.toLowerCase()))
        .toList();

    return Column(
      children: [
        const SizedBox(height: 4),
        const Text(
          'Choose Exercise',
          style: TextStyle(
            color: FitColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            onChanged: (value) => setState(() => _query = value),
            style: const TextStyle(color: FitColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Search exercise',
              hintStyle: TextStyle(color: FitColors.textSecondary),
              prefixIcon:
                  Icon(Icons.search, color: FitColors.textSecondary),
              filled: true,
              fillColor: FitColors.cardFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final exercise = filtered[index];
              return ListTile(
                minVerticalPadding: 12,
                title: Text(
                  exercise.name,
                  style: const TextStyle(color: FitColors.textPrimary),
                ),
                subtitle: Text(
                  exercise.movementPattern.name,
                  style: TextStyle(color: FitColors.textSecondary),
                ),
                onTap: () => Navigator.of(context).pop(exercise),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tracking Scheme Picker
// ---------------------------------------------------------------------------

class _TrackingSchemeContent extends StatelessWidget {
  final TrackingScheme suggested;
  const _TrackingSchemeContent({required this.suggested});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        const Text(
          'Choose Tracking Style',
          style: TextStyle(
            color: FitColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: ListView(
            children: TrackingScheme.values.map((scheme) {
              final isSuggested = scheme == suggested;
              return ListTile(
                minVerticalPadding: 12,
                title: Text(
                  trackingSchemeLabel(scheme),
                  style: const TextStyle(color: FitColors.textPrimary),
                ),
                trailing: isSuggested
                    ? const Text(
                        'Suggested',
                        style: TextStyle(
                          color: FitColors.signalGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : null,
                onTap: () => Navigator.of(context).pop(scheme),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _RealTimeBiomechanicalHUD extends ConsumerStatefulWidget {
  const _RealTimeBiomechanicalHUD();

  @override
  ConsumerState<_RealTimeBiomechanicalHUD> createState() =>
      _RealTimeBiomechanicalHUDState();
}

class _RealTimeBiomechanicalHUDState extends ConsumerState<_RealTimeBiomechanicalHUD>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hudData = ref.watch(activeBiomechanicalHUDProvider);

    // Listen for set logging to trigger pulse
    ref.listen(workoutSessionProvider, (previous, next) {
      final prevSets = previous?.exercises.fold<int>(0, (sum, e) => sum + e.sets.length) ?? 0;
      final nextSets = next.exercises.fold<int>(0, (sum, e) => sum + e.sets.length);
      if (nextSets > prevSets) {
        _pulseController.forward(from: 0);
      }
    });

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.fastOutSlowIn,
              width: _isExpanded ? MediaQuery.of(context).size.width - 32 : 160,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(_isExpanded ? 24 : 30),
                border: Border.all(
                  color: Color.lerp(
                    Colors.white.withValues(alpha: 0.1),
                    FitColors.cyberCyan.withValues(alpha: 0.5),
                    _pulseController.value,
                  )!,
                  width: 1 + (_pulseController.value * 1.5),
                ),
                boxShadow: _pulseController.value > 0.01 ? [
                  BoxShadow(
                    color: FitColors.cyberCyan.withValues(alpha: 0.3 * _pulseController.value),
                    blurRadius: 15 * _pulseController.value,
                    spreadRadius: 2 * _pulseController.value,
                  ),
                ] : [],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_isExpanded ? 24 : 30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: _isExpanded ? _buildDashboard(hudData) : _buildPill(hudData),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPill(BiomechanicalHUDData data) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _AnimatedHudIcon(
          icon: Icons.biotech_rounded,
          controller: _pulseController,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'TELEMETRY',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 8,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            Text(
              '${data.totalWeightedVolume.toStringAsFixed(1)} VOL',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                fontFamily: 'SpaceGrotesk',
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        const Icon(Icons.keyboard_arrow_up, color: Colors.white24, size: 14),
      ],
    );
  }

  Widget _buildDashboard(BiomechanicalHUDData data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  _AnimatedHudIcon(
                    icon: Icons.biotech_rounded,
                    controller: _pulseController,
                  ),
                  const SizedBox(width: 8),
                  const Flexible(
                    child: Text(
                      'KINETIC TELEMETRY',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white38,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: _HudMetric(
                label: 'CNS STRAIN',
                value: '${data.cnsLoad.toInt()}',
                unit: 'U',
                color: FitColors.cyberCyan,
              ),
            ),
            Expanded(
              child: _HudMetric(
                label: 'WEIGHTED VOL',
                value: data.totalWeightedVolume.toStringAsFixed(1),
                unit: 'S',
                color: FitColors.signalAmber,
              ),
            ),
            Expanded(
              child: _HudMetric(
                label: 'BIOMECH FOCUS',
                value: data.topMuscleGroup.toUpperCase(),
                unit: '',
                color: FitColors.signalGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class _HudMetric extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _HudMetric({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white38, fontSize: 8, letterSpacing: 0.5),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16,
                fontFamily: 'SpaceGrotesk',
              ),
            ),
            if (unit.isNotEmpty) ...[
              const SizedBox(width: 2),
              Text(
                unit,
                style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _AnimatedHudIcon extends StatelessWidget {
  final IconData icon;
  final AnimationController controller;

  const _AnimatedHudIcon({required this.icon, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final scale = 1.0 + (0.3 * controller.value);
        return Transform.scale(
          scale: scale,
          child: Icon(
            icon,
            color: Color.lerp(Colors.white70, FitColors.cyberCyan, controller.value),
            size: 18,
          ),
        );
      },
    );
  }
}
