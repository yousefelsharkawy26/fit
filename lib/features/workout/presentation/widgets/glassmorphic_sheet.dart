/// glassmorphic_sheet.dart
///
/// A premium bottom-sheet scaffold with real glassmorphism via [BackdropFilter].
/// Replaces the opaque [WorkoutBottomSheetScaffold] for all modal surfaces.
library;

import 'package:flutter/material.dart';
import 'package:fit/features/common/design_tokens.dart';

/// Glassmorphic bottom-sheet wrapper with frosted-glass backdrop blur.
///
/// Usage:
/// ```dart
/// showModalBottomSheet(
///   backgroundColor: Colors.transparent,
///   builder: (_) => GlassmorphicSheet(child: YourContent()),
/// );
/// ```
class GlassmorphicSheet extends StatelessWidget {
  final Widget child;
  final double? maxHeightFraction;

  const GlassmorphicSheet({
    super.key,
    required this.child,
    this.maxHeightFraction,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(FitRadii.card),
      ),
      child: BackdropFilter(
        filter: FitBlur.glassFilter,
        child: Container(
          decoration: BoxDecoration(
            color: FitColors.obsidianSurface.withValues(alpha: 0.85),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(FitRadii.card),
            ),
            border: Border.all(color: FitColors.cardBorder),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _DragHandle(),
                Flexible(child: child),
              ],
            ),
          ),
        ),
      ),
    );

    if (maxHeightFraction != null) {
      content = ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * maxHeightFraction!,
        ),
        child: content,
      );
    }

    return content;
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Center(
        child: Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(FitRadii.pill),
          ),
        ),
      ),
    );
  }
}
