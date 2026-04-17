import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fit/features/coaching/domain/models/muscle_fatigue_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../../../common/design_tokens.dart';

class Anatomical3DViewer extends StatefulWidget {
  final List<MuscleFatigueState> fatigueStates;

  const Anatomical3DViewer({super.key, required this.fatigueStates});

  @override
  State<Anatomical3DViewer> createState() => _Anatomical3DViewerState();
}

class _Anatomical3DViewerState extends State<Anatomical3DViewer> {
  String? _htmlData;

  @override
  void initState() {
    super.initState();
    _loadHtmlTemplate();
  }

  @override
  void didUpdateWidget(Anatomical3DViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fatigueStates != widget.fatigueStates) {
      _loadHtmlTemplate();
    }
  }

  Future<void> _loadHtmlTemplate() async {
    try {
      String template = await rootBundle.loadString(
        'assets/3d/anatomical_map.html',
      );

      // Inject colors based on fatigue states
      template = template.replaceAll('{{CHEST_COLOR}}', _getColorFor('chest'));
      template = template.replaceAll(
        '{{SHOULDERS_COLOR}}',
        _getColorFor('shoulders'),
      );
      template = template.replaceAll('{{ABS_COLOR}}', _getColorFor('core'));
      template = template.replaceAll('{{LEGS_COLOR}}', _getColorFor('legs'));
      template = template.replaceAll('{{BACK_COLOR}}', _getColorFor('back'));

      setState(() {
        _htmlData = template;
      });
    } catch (e) {
      debugPrint('Error loading 3D template: $e');
    }
  }

  String _getColorFor(String muscleId) {
    final state = widget.fatigueStates.firstWhere(
      (s) => s.muscleGroup.toLowerCase().contains(muscleId),
      orElse: () => MuscleFatigueState.fromACWR(muscleId, 1.0),
    );

    final color = state.color;
    return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  @override
  Widget build(BuildContext context) {
    // model_viewer_plus does not support Linux desktop.
    // Fallback to a placeholder or 2D map if on unsupported desktop platforms.
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.macOS)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.threed_rotation,
              size: 48,
              color: StyleSeedColors.accentCyan,
            ),
            const SizedBox(height: 16),
            Text(
              '3D View Supported on Mobile & Web',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: StyleSeedColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please run with: flutter run -d chrome',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: StyleSeedColors.accentCyan.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      );
    }

    if (_htmlData == null) {
      return const Center(
        child: CircularProgressIndicator(color: StyleSeedColors.accentCyan),
      );
    }

    final String dataUri =
        'data:text/html;base64,${base64Encode(utf8.encode(_htmlData!))}';

    return ModelViewer(
      backgroundColor: Colors.transparent,
      src: dataUri,
      alt: "A 3D anatomical visual twin",
      autoRotate: false,
      cameraControls: true,
      shadowIntensity: 1,
    );
  }
}
