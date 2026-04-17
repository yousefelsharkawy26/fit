import 'package:flutter/material.dart';
import '../../domain/models/muscle_fatigue_state.dart';

class AnatomicalMapPainter extends CustomPainter {
  final List<MuscleFatigueState> fatigueStates;
  final double animationValue;

  AnatomicalMapPainter({
    required this.fatigueStates,
    this.animationValue = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scale = size.width / 200; // Original coordinates based on 200 width

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withValues(alpha: 0.1);

    // 1. Draw Wireframe Body Outline
    _drawHumanWireframe(canvas, center, scale, paint);

    // 2. Map and Draw Glowing Muscle Paths
    for (final state in fatigueStates) {
      _paintMuscleGroup(canvas, center, scale, state);
    }
  }

  void _drawHumanWireframe(Canvas canvas, Offset center, double scale, Paint paint) {
    // Simplified human figure outline
    final head = Rect.fromCenter(center: center.translate(0, -70 * scale), width: 25 * scale, height: 30 * scale);
    canvas.drawOval(head, paint);

    final torso = Path()
      ..moveTo(center.dx - 30 * scale, center.dy - 50 * scale)
      ..lineTo(center.dx + 30 * scale, center.dy - 50 * scale)
      ..lineTo(center.dx + 20 * scale, center.dy + 30 * scale)
      ..lineTo(center.dx - 20 * scale, center.dy + 30 * scale)
      ..close();
    canvas.drawPath(torso, paint);

    // Arms
    final leftArm = Path()
      ..moveTo(center.dx - 30 * scale, center.dy - 50 * scale)
      ..lineTo(center.dx - 60 * scale, center.dy + 10 * scale);
    final rightArm = Path()
      ..moveTo(center.dx + 30 * scale, center.dy - 50 * scale)
      ..lineTo(center.dx + 60 * scale, center.dy + 10 * scale);
    canvas.drawPath(leftArm, paint);
    canvas.drawPath(rightArm, paint);

    // Legs
    final leftLeg = Path()
      ..moveTo(center.dx - 15 * scale, center.dy + 30 * scale)
      ..lineTo(center.dx - 20 * scale, center.dy + 90 * scale);
    final rightLeg = Path()
      ..moveTo(center.dx + 15 * scale, center.dy + 30 * scale)
      ..lineTo(center.dx + 20 * scale, center.dy + 90 * scale);
    canvas.drawPath(leftLeg, paint);
    canvas.drawPath(rightLeg, paint);
  }

  void _paintMuscleGroup(Canvas canvas, Offset center, double scale, MuscleFatigueState state) {
    final musclePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = state.color.withValues(alpha: 0.4);

    if (state.isPulsing) {
      // Add neon glow effect
      final bloomLevel = (animationValue * 10.0).clamp(5.0, 15.0);
      musclePaint.maskFilter = MaskFilter.blur(BlurStyle.normal, bloomLevel);
      musclePaint.color = state.color.withValues(alpha: 0.3 + (animationValue * 0.4));
    }

    final path = _getPathForMuscleGroup(state.muscleGroup, center, scale);
    if (path != null) {
      canvas.drawPath(path, musclePaint);
      
      // Draw a sharper border
      final borderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = state.color;
      canvas.drawPath(path, borderPaint);
    }
  }

  Path? _getPathForMuscleGroup(String group, Offset center, double scale) {
    final normalized = group.toLowerCase();
    
    // Geometric definitions for muscle zones
    if (normalized.contains('chest')) {
      return Path()
        ..moveTo(center.dx - 25 * scale, center.dy - 40 * scale)
        ..lineTo(center.dx - 5 * scale, center.dy - 40 * scale)
        ..lineTo(center.dx - 5 * scale, center.dy - 20 * scale)
        ..lineTo(center.dx - 20 * scale, center.dy - 15 * scale)
        ..close()
        ..addPath(
          Path()
            ..moveTo(center.dx + 25 * scale, center.dy - 40 * scale)
            ..lineTo(center.dx + 5 * scale, center.dy - 40 * scale)
            ..lineTo(center.dx + 5 * scale, center.dy - 20 * scale)
            ..lineTo(center.dx + 20 * scale, center.dy - 15 * scale)
            ..close(),
          Offset.zero,
        );
    }
    
    if (normalized.contains('back') || normalized.contains('lats')) {
      // Shown in a semi-profile or inferred via torso outline
      return Path()
        ..moveTo(center.dx - 30 * scale, center.dy - 45 * scale)
        ..lineTo(center.dx - 20 * scale, center.dy - 45 * scale)
        ..lineTo(center.dx - 15 * scale, center.dy + 20 * scale)
        ..lineTo(center.dx - 25 * scale, center.dy + 20 * scale)
        ..close()
        ..addPath(
          Path()
            ..moveTo(center.dx + 30 * scale, center.dy - 45 * scale)
            ..lineTo(center.dx + 20 * scale, center.dy - 45 * scale)
            ..lineTo(center.dx + 15 * scale, center.dy + 20 * scale)
            ..lineTo(center.dx + 25 * scale, center.dy + 20 * scale)
            ..close(),
          Offset.zero,
        );
    }

    if (normalized.contains('quads')) {
      return Path()
        ..moveTo(center.dx - 20 * scale, center.dy + 35 * scale)
        ..lineTo(center.dx - 5 * scale, center.dy + 35 * scale)
        ..lineTo(center.dx - 8 * scale, center.dy + 70 * scale)
        ..lineTo(center.dx - 22 * scale, center.dy + 70 * scale)
        ..close()
        ..addPath(
          Path()
            ..moveTo(center.dx + 20 * scale, center.dy + 35 * scale)
            ..lineTo(center.dx + 5 * scale, center.dy + 35 * scale)
            ..lineTo(center.dx + 8 * scale, center.dy + 70 * scale)
            ..lineTo(center.dx + 22 * scale, center.dy + 70 * scale)
            ..close(),
          Offset.zero,
        );
    }

    if (normalized.contains('shoulders') || normalized.contains('delts')) {
       return Path()
        ..addOval(Rect.fromCenter(center: center.translate(-30 * scale, -45 * scale), width: 12 * scale, height: 15 * scale))
        ..addOval(Rect.fromCenter(center: center.translate(30 * scale, -45 * scale), width: 12 * scale, height: 15 * scale));
    }

    if (normalized.contains('core') || normalized.contains('abs')) {
      return Path()
        ..addRect(Rect.fromCenter(center: center.translate(0, -5 * scale), width: 15 * scale, height: 40 * scale));
    }

    return null;
  }

  @override
  bool shouldRepaint(covariant AnatomicalMapPainter oldDelegate) {
    return oldDelegate.fatigueStates != fatigueStates || oldDelegate.animationValue != animationValue;
  }
}
