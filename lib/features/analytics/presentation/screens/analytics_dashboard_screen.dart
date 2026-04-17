import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../coaching/domain/models/coaching_context.dart';
import '../providers/analytics_providers.dart';
import '../../domain/models/analytics_models.dart';

class AnalyticsDashboardScreen extends ConsumerWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadSummaryAsync = ref.watch(biomechanicalLoadProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E), // Obsidian
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF0E0E0E),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              title: const Text(
                'PERFORMANCE VECTORS',
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk', // Using the technical font
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          loadSummaryAsync.when(
            data: (summary) => SliverList(
              delegate: SliverChildListDelegate([
                _MetricHUD(summary: summary),
                const _SectionHeader(title: 'PERFORMANCE SIGNATURE (7D)'),
                _MovementSymmetryChart(balance: summary.movementPatternBalance),
                const _SectionHeader(title: 'BIOMECHANICAL HEATMAP (ACWR)'),
                _MuscleHeatmap(muscleIntensity: summary.muscleIntensity),
                const _SectionHeader(title: 'CNS FATIGUE LOAD'),
                _CnsFatigueGauge(trend: summary.cnsFatigueTrend),
                const _SectionHeader(title: 'VOLUME TREND (30D)'),
                _PerformanceChart(trend: summary.volumeTrend),
                const _SectionHeader(title: '1RM PROJECTION (TOP EXERCISES)'),
                _TopExercisesList(exercises: summary.topExercises),
                const SizedBox(height: 100), // Bottom padding for nav bar
              ]),
            ),
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFF00CFFC)),
              ),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'Error: $err',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class _MetricHUD extends StatelessWidget {
  final BiomechanicalLoadSummary summary;
  const _MetricHUD({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _StatBlock(
            label: 'WEEKLY LOAD',
            value: '${(summary.weeklyVolumeLoad / 1000).toStringAsFixed(1)}t',
            color: const Color(0xFF00CFFC),
          ),
          _StatBlock(
            label: 'SESSIONS',
            value: summary.sessionCount.toString(),
            color: const Color(0xFF97A9FF),
          ),
          _StatBlock(
            label: 'STATUS',
            value: summary.recoveryStatus,
            color: summary.recoveryStatus == 'PRIME'
                ? const Color(0xFF00FF41)
                : const Color(0xFFFFD16F),
          ),
        ],
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatBlock({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'SpaceGrotesk',
          ),
        ),
      ],
    );
  }
}

class _MovementSymmetryChart extends StatelessWidget {
  final Map<String, double> balance;

  const _MovementSymmetryChart({required this.balance});

  @override
  Widget build(BuildContext context) {
    const patterns = ['push', 'pull', 'hinge', 'squat', 'carry', 'rotation'];
    final dataSets = [
      RadarDataSet(
        fillColor: const Color(0xFF00CFFC).withValues(alpha: 0.2),
        borderColor: const Color(0xFF00CFFC),
        entryRadius: 3,
        dataEntries: patterns.map((p) {
          final value = balance[p] ?? 0.0;
          return RadarEntry(value: value);
        }).toList(),
      ),
    ];

    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131314),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: RadarChart(
        RadarChartData(
          dataSets: dataSets,
          radarBackgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          radarBorderData: const BorderSide(color: Colors.white10),
          titlePositionPercentageOffset: 0.2,
          titleTextStyle: const TextStyle(color: Colors.white54, fontSize: 10),
          getTitle: (index, angle) {
            return RadarChartTitle(
              text: patterns[index].toUpperCase(),
              angle: angle,
            );
          },
          tickCount: 1,
          ticksTextStyle: const TextStyle(color: Colors.transparent),
          gridBorderData: const BorderSide(color: Colors.white10, width: 1),
        ),
      ),
    );
  }
}

class _CnsFatigueGauge extends StatelessWidget {
  final List<CnsLoadSnapshot> trend;

  const _CnsFatigueGauge({required this.trend});

  @override
  Widget build(BuildContext context) {
    final latestLoad = trend.isNotEmpty ? trend.last.load : 0.0;
    // Normalize: 0-50 range for gauge
    final percentage = (latestLoad / 50.0).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131314),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'NEUROLOGICAL STRAIN',
                style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1.0),
              ),
              Text(
                '${latestLoad.toInt()} UNITS',
                style: TextStyle(
                  color: percentage > 0.8 ? Colors.redAccent : const Color(0xFF00CFFC),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SpaceGrotesk',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              color: percentage > 0.8 ? Colors.redAccent : const Color(0xFF00CFFC),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            percentage > 0.8 
                ? 'HIGH CNS FATIGUE: DELOAD RECOMMENDED' 
                : 'OPTIMAL CNS CAPACITY',
            style: TextStyle(
              color: percentage > 0.8 ? Colors.redAccent.withValues(alpha: 0.7) : Colors.white24,
              fontSize: 9,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _MuscleHeatmap extends StatelessWidget {
  final Map<String, double> muscleIntensity;

  const _MuscleHeatmap({required this.muscleIntensity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.0,
        ),
        itemCount: _kAllRegions.length,
        itemBuilder: (context, index) {
          final region = _kAllRegions[index];
          final intensity = muscleIntensity[region] ?? 0.0;
          return _HeatmapBlock(name: region, intensity: intensity);
        },
      ),
    );
  }
}

class _HeatmapBlock extends StatelessWidget {
  final String name;
  final double intensity;

  const _HeatmapBlock({required this.name, required this.intensity});

  @override
  Widget build(BuildContext context) {
    // Reverse-engineer the ACWR from the clamped intensity scaling (intensity = acwr / 1.5)
    final acwr = intensity * 1.5;
    
    Color color;
    if (acwr > 1.4) {
      // Danger zone (overtraining)
      color = Color.lerp(const Color(0xFF00CFFC), Colors.redAccent, ((acwr - 1.4) / 0.5).clamp(0.0, 1.0))!;
    } else if (acwr >= 0.8) {
      // Sweet spot
      color = const Color(0xFF00CFFC);
    } else if (acwr > 0) {
      // Detraining / very light
      color = Color.lerp(const Color(0xFF1A1A1A), const Color(0xFF00CFFC), (acwr / 0.8).clamp(0.0, 1.0))!;
    } else {
      color = const Color(0xFF1A1A1A); // Inactive
    }

    return Tooltip(
      message: '$name: ${acwr.toStringAsFixed(2)} ACWR',
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: acwr > 1.4 ? 1.0 : 0.8),
          borderRadius: BorderRadius.circular(4),
          boxShadow: acwr >= 0.8
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
    );
  }
}

class _PerformanceChart extends StatelessWidget {
  final List<PerformanceTrendPoint> trend;

  const _PerformanceChart({required this.trend});

  @override
  Widget build(BuildContext context) {
    if (trend.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'No trend data available',
            style: TextStyle(color: Colors.white24),
          ),
        ),
      );
    }

    return Container(
      height: 240,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131314),
        borderRadius: BorderRadius.circular(12),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: trend.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value.value);
              }).toList(),
              isCurved: true,
              color: const Color(0xFF00CFFC),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF00CFFC).withValues(alpha: 0.3),
                    const Color(0xFF00CFFC).withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const List<String> _kAllRegions = [
  'Upper Chest',
  'Lower Chest',
  'Front Delt',
  'Side Delt',
  'Rear Delt',
  'Lats',
  'Upper Back',
  'Lower Back',
  'Biceps',
  'Triceps',
  'Forearms',
  'Abs',
  'Obliques',
  'Quads',
  'Hamstrings',
  'Glutes',
  'Calves',
  'Adductors',
  'Abductors',
];

class _TopExercisesList extends StatelessWidget {
  final List<PerformanceSnapshot> exercises;
  const _TopExercisesList({required this.exercises});

  @override
  Widget build(BuildContext context) {
    if (exercises.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'No performance benchmarks recorded.',
          style: TextStyle(color: Colors.white24, fontSize: 12),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: exercises
            .map((ex) => _BottomSnapshotRow(snapshot: ex))
            .toList(),
      ),
    );
  }
}

class _BottomSnapshotRow extends StatelessWidget {
  final PerformanceSnapshot snapshot;
  const _BottomSnapshotRow({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131314),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snapshot.exerciseName.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'PROJECTED 1RM: ${snapshot.oneRepMaxEstimate.toStringAsFixed(1)}kg',
                style: const TextStyle(color: Colors.white54, fontSize: 10),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: snapshot.weeklyTrend >= 0
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${snapshot.weeklyTrend >= 0 ? "+" : ""}${snapshot.weeklyTrend.toStringAsFixed(1)}%',
              style: TextStyle(
                color: snapshot.weeklyTrend >= 0
                    ? const Color(0xFF00FF41)
                    : Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
