import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/design_tokens.dart';
import '../providers/visual_twin_provider.dart';
import 'anatomical_3d_viewer.dart';

class AnatomicalVisualTwin extends ConsumerStatefulWidget {
  const AnatomicalVisualTwin({super.key});

  @override
  ConsumerState<AnatomicalVisualTwin> createState() => _AnatomicalVisualTwinState();
}

class _AnatomicalVisualTwinState extends ConsumerState<AnatomicalVisualTwin> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncFatigue = ref.watch(visualTwinProvider);
    return Container(
      decoration: BoxDecoration(
        color: StyleSeedColors.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: StyleSeedColors.borderSubtle),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background grid or texture
            _buildBackgroundDesign(),
            
            asyncFatigue.when(
              data: (states) => Anatomical3DViewer(fatigueStates: states),
              loading: () => const Center(
                child: CircularProgressIndicator(color: StyleSeedColors.accentCyan),
              ),
              error: (err, _) => Center(
                child: Text(
                  'Visual Sync Failed',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: StyleSeedColors.borderError),
                ),
              ),
            ),
            
            // Labels / Legend overlay
            Positioned(
              bottom: 16,
              left: 16,
              child: _buildLegend(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundDesign() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.05,
        child: GridPaper(
          color: StyleSeedColors.accentCyan,
          divisions: 1,
          subdivisions: 4,
          interval: 100,
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LegendItem(color: StyleSeedColors.accentPink, label: 'Danger (>1.5)'),
        _LegendItem(color: StyleSeedColors.borderWarning, label: 'Pushing (1.2-1.5)'),
        _LegendItem(color: StyleSeedColors.accentCyan, label: 'Optimal (0.8-1.2)'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: StyleSeedColors.textSecondary, fontSize: 10)),
      ],
    );
  }
}
