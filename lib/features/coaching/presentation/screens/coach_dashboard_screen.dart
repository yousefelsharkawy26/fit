import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:fit/features/common/presentation/navigation/app_shell.dart';
import '../../domain/services/coach_reasoning_engine.dart';
import '../../domain/services/split_auditor_service.dart';
import '../../../gamification/presentation/widgets/retention_status_card.dart';
import '../../../gamification/presentation/widgets/muscle_level_list.dart';
import '../../../ontology/presentation/screens/safety_center_screen.dart';
import '../../../gamification/presentation/widgets/gamification_overlay_listener.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../providers/coaching_providers.dart';
import '../widgets/fix_my_split_paywall.dart';
import '../../domain/models/coaching_context.dart';
import '../widgets/biological_readiness_card.dart';
import '../widgets/anatomical_visual_twin.dart';

/// The main entry point for the coaching experience.
class CoachDashboardScreen extends ConsumerWidget {
  const CoachDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(coachingDashboardProvider);
    final insightAsync = ref.watch(coachInsightProvider);

    return GamificationOverlayListener(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFF0F172A),
          appBar: _buildAppBar(context, ref),
          body: TabBarView(
            children: [
              // Tab 1: Overview
              dashboardAsync.when(
                data: (state) => CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(16.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate.fixed([
                          _SafetyShield(report: state.auditReport),
                          const SizedBox(height: 16),
                          const BiologicalReadinessCard(),
                          const SizedBox(height: 16),
                          const _QuickStartCTA(),
                          const SizedBox(height: 16),
                          const RetentionStatusCard(),
                          const SizedBox(height: 24),
                          _InsightSection(insightAsync: insightAsync),
                          const SizedBox(height: 24),
                          _PerformanceSignatureRadar(
                            patterns: state.context.movementPatternVolumes,
                          ),
                          const SizedBox(height: 24),
                          const MuscleLevelList(),
                          const SizedBox(height: 24),
                          const _SectionHeader(title: 'PERFORMANCE SNAPSHOTS'),
                          const SizedBox(height: 12),
                          _PerformanceGrid(exercises: state.context.topExercises),
                          const SizedBox(height: 24),
                          _InteractiveVolumeSummary(
                            volumes: state.context.weeklyVolume,
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Colors.cyanAccent),
                ),
                error: (e, _) => Center(
                  child: Text(
                    'Error: $e',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
              
              // Tab 2: Body Map (The Visual Twin)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: AnatomicalVisualTwin(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text(
        'COACHING ENGINE',
        style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: () => ref.invalidate(coachingDashboardProvider),
        ),
        IconButton(
          icon: const Icon(Icons.account_circle_outlined, color: Colors.cyanAccent),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          ),
        ),
      ],
      bottom: const TabBar(
        tabs: [
          Tab(text: 'OVERVIEW', icon: Icon(Icons.dashboard_rounded)),
          Tab(text: 'BODY MAP', icon: Icon(Icons.person_pin_rounded)),
        ],
        indicatorColor: Colors.cyanAccent,
        labelColor: Colors.cyanAccent,
        unselectedLabelColor: Colors.white54,
        dividerColor: Colors.transparent,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    );
  }
}

class _SafetyShield extends StatelessWidget {
  final AuditReport report;
  const _SafetyShield({required this.report});

  @override
  Widget build(BuildContext context) {
    final hasIssues = report.issues.isNotEmpty;
    final color = hasIssues ? Colors.orangeAccent : Colors.blueAccent;
    final icon = hasIssues ? Icons.warning_amber_rounded : Icons.shield_rounded;
    final title = hasIssues ? 'SAFETY ALERT' : 'SYSTEMS CLEAR';
    final subtitle = hasIssues
        ? report.issues.first.message
        : 'No biomechanical constraints detected.\nTap to view Safety Radius.';

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SafetyCenterScreen()),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (hasIssues)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.black,
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 0,
                      ),
                      onPressed: () => FixMySplitPaywall.show(context),
                      child: const Text('Fix', style: TextStyle(fontWeight: FontWeight.w900)),
                    )
                  else
                    Icon(Icons.chevron_right, color: color),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InsightSection extends StatelessWidget {
  final AsyncValue<CoachResponse> insightAsync;
  const _InsightSection({required this.insightAsync});

  @override
  Widget build(BuildContext context) {
    return insightAsync.when(
      data: (response) => _ResponseCard(response: response),
      loading: () => const _LoadingCard(message: 'Analyzing Biomechanical Logs...'),
      error: (e, _) => _ErrorCard(error: e.toString()),
    );
  }
}

class _ResponseCard extends StatelessWidget {
  final CoachResponse response;
  const _ResponseCard({required this.response});

  String get title {
    return switch (response) {
      CoachRecommendation() => 'AI RECOMMENDATION',
      CoachAlert() => 'SAFETY INTERVENTION',
      CoachSplitChange() => 'STRATEGIC REALIGNMENT',
    };
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan.withValues(alpha: 0.15),
                Colors.blue.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.psychology_outlined, color: Colors.cyanAccent),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.cyanAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return switch (response) {
      CoachRecommendation(suggestion: var s, scientificRationale: var r) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.science_outlined, size: 16, color: Colors.white54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'RATIONALE:\n$r',
                      style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      CoachAlert(title: var t, message: var m) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t, style: const TextStyle(color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(m, style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.4)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => FixMySplitPaywall.show(context),
              icon: const Icon(Icons.auto_fix_high_rounded),
              label: const Text('Fix My Split'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            )
          ],
        ),
      CoachSplitChange(newSplitName: var ns, reasoning: var res) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Switch to $ns', style: const TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...res.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.check_circle_outline, color: Colors.orangeAccent, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(p, style: const TextStyle(color: Colors.white, height: 1.3))),
                ],
              ),
            )),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => FixMySplitPaywall.show(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.orangeAccent,
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
              child: const Text('Apply Changes Now →'),
            )
          ],
        ),
    };
  }
}

class _LoadingCard extends StatelessWidget {
  final String message;
  const _LoadingCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 2,
            child: LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.white54, fontSize: 14)),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String error;
  const _ErrorCard({required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
      ),
      child: Text('Reasoning Failed: $error', style: const TextStyle(color: Colors.redAccent)),
    );
  }
}

class _PerformanceGrid extends StatelessWidget {
  final List<dynamic> exercises;
  const _PerformanceGrid({required this.exercises});

  @override
  Widget build(BuildContext context) {
    if (exercises.isEmpty) {
      return const Text('No recent PR data available.', style: TextStyle(color: Colors.white38));
    }
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: exercises.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final ex = exercises[index];
          final positive = ex.weeklyTrend >= 0;
          return Container(
            width: 160,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ex.exerciseName.toUpperCase(),
                  style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${ex.oneRepMaxEstimate.toStringAsFixed(1)}kg',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: positive ? Colors.greenAccent.withValues(alpha: 0.1) : Colors.redAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        positive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                        color: positive ? Colors.greenAccent : Colors.redAccent,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${ex.weeklyTrend.abs().toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: positive ? Colors.greenAccent : Colors.redAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _QuickStartCTA extends ConsumerWidget {
  const _QuickStartCTA();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.cyanAccent, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => ref.read(navigationIndexProvider.notifier).state = 1,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.fitness_center_rounded, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'READY FOR ACTION',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        'Start Today\'s Session',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_rounded, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InteractiveVolumeSummary extends ConsumerWidget {
  final List<dynamic> volumes;
  const _InteractiveVolumeSummary({required this.volumes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => ref.read(navigationIndexProvider.notifier).state = 2, // Analytics
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'MUSCLE WORKLOAD (SETS)',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.white.withValues(alpha: 0.3)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ...volumes.take(4).map((v) => _VolumeRow(v: v)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VolumeRow extends StatelessWidget {
  final dynamic v;
  const _VolumeRow({required this.v});

  Color _getVolumeColor(double sets) {
    if (sets > 15) return Colors.orangeAccent;
    if (sets > 10) return Colors.cyanAccent;
    return Colors.blueAccent;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getVolumeColor(v.volume);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(v.muscleName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              Text('${v.volume.toStringAsFixed(1)} sets', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (v.volume / 20).clamp(0, 1),
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              color: color,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _PerformanceSignatureRadar extends StatelessWidget {
  final List<MovementPatternVolume> patterns;

  const _PerformanceSignatureRadar({required this.patterns});

  @override
  Widget build(BuildContext context) {
    if (patterns.isEmpty) return const SizedBox.shrink();

    // RadarChart requires at least 3 entries to render.
    // If fewer, we show a clean "Calibration" state to maintain HUD aesthetic.
    if (patterns.length < 3) {
      return _buildCalibratingContainer();
    }

    final dataSets = [
      RadarDataSet(
        fillColor: Colors.cyanAccent.withValues(alpha: 0.15),
        borderColor: Colors.cyanAccent,
        entryRadius: 2,
        dataEntries: patterns.map((p) => RadarEntry(value: p.volume)).toList(),
      ),
    ];

    return Container(
      height: 340,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          Expanded(
            child: RadarChart(
              RadarChartData(
                dataSets: dataSets,
                radarBackgroundColor: Colors.transparent,
                borderData: FlBorderData(show: false),
                radarBorderData: const BorderSide(color: Colors.white10),
                titlePositionPercentageOffset: 0.2,
                titleTextStyle: const TextStyle(
                  color: Colors.white54,
                  fontSize: 9,
                  fontFamily: 'SpaceGrotesk',
                  fontWeight: FontWeight.bold,
                ),
                getTitle: (index, angle) {
                  return RadarChartTitle(
                    text: patterns[index].pattern.toUpperCase(),
                    angle: angle,
                  );
                },
                tickCount: 1,
                ticksTextStyle: const TextStyle(color: Colors.transparent),
                gridBorderData: const BorderSide(color: Colors.white10, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PERFORMANCE SIGNATURE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontFamily: 'SpaceGrotesk',
              ),
            ),
            Text(
              'BIOMECHANICAL BIAS',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 9,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontFamily: 'SpaceGrotesk',
              ),
            ),
          ],
        ),
        const Icon(Icons.radar_rounded, color: Colors.cyanAccent, size: 20),
      ],
    );
  }

  Widget _buildCalibratingContainer() {
    return Container(
      height: 200, // Shorter for calibration
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHeader(),
          const Spacer(),
          const Icon(Icons.query_stats_rounded, color: Colors.white10, size: 48),
          const SizedBox(height: 16),
          const Text(
            'CALIBRATING TELEMETRY...',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontFamily: 'SpaceGrotesk',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'LOG 3 DIFFERENT MOVEMENT PATTERNS TO REVEAL SIGNATURE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.1),
              fontSize: 8,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              fontFamily: 'SpaceGrotesk',
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
