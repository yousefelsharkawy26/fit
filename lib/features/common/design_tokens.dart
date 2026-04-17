/// design_tokens.dart
///
/// Kinetic Precision V2 — Design Token System.
/// Provides [FitThemeData] as a typed extension on [ThemeData] for
/// future-proof, system-aware theming across all FitOS surfaces.
library;

import 'dart:ui';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color Tokens
// ---------------------------------------------------------------------------
abstract final class StyleSeedColors {
  static const Color accentCyan = Color(0xFF00E5FF);
  static const Color accentViolet = Color(0xFF9400FF);
  static const Color accentPink = Color(0xFFFF006E);
  static const Color surfaceDark = Color(0xFF111827);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textTertiary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF4B5563);
  static const Color borderSubtle = Color(0xFF374151);
  static const Color borderStrong = Color(0xFF4B5563);
  static const Color borderFocus = Color(0xFF00E5FF);
  static const Color borderError = Color(0xFFFF5252);
  static const Color borderSuccess = Color(0xFF69F0AE);
  static const Color borderWarning = Color(0xFFFFD740);
  static const Color borderAccent = Color(0xFF00E5FF);
}

/// Core palette constants for direct use in one-off styling.
abstract final class FitColors {
  // Backgrounds
  static const Color obsidian = Color(0xFF0A0A0C);
  static const Color obsidianSurface = Color(0xFF111827);
  static const Color obsidianElevated = Color(0xFF1E293B);

  // Primary accent
  static const Color cyberCyan = Color(0xFF00E5FF);
  static Color cyberCyanMuted = cyberCyan.withValues(alpha: 0.12);
  static Color cyberCyanGlow = cyberCyan.withValues(alpha: 0.30);

  // Signal colors
  static const Color signalGreen = Color(0xFF69F0AE);
  static const Color signalAmber = Color(0xFFFFD740);
  static const Color signalRed = Color(0xFFFF5252);

  // Text
  static const Color textPrimary = Colors.white;
  static Color textSecondary = Colors.white.withValues(alpha: 0.54);
  static Color textTertiary = Colors.white.withValues(alpha: 0.38);

  // Borders & surfaces
  static Color cardBorder = Colors.white.withValues(alpha: 0.08);
  static Color cardFill = Colors.white.withValues(alpha: 0.06);
}

// ---------------------------------------------------------------------------
// Shape & Radius Tokens
// ---------------------------------------------------------------------------

abstract final class FitRadii {
  static const double card = 20.0;
  static const double button = 14.0;
  static const double pill = 999.0;
  static const double stepper = 8.0;
  static const double input = 10.0;
}

// ---------------------------------------------------------------------------
// Blur Tokens (Glassmorphism)
// ---------------------------------------------------------------------------

abstract final class FitBlur {
  static const double glass = 20.0;

  /// Ready-to-use [ImageFilter] for BackdropFilter.
  static ImageFilter get glassFilter =>
      ImageFilter.blur(sigmaX: glass, sigmaY: glass);
}

// ---------------------------------------------------------------------------
// Animation Tokens
// ---------------------------------------------------------------------------

abstract final class FitDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration pulse = Duration(milliseconds: 1500);
}

abstract final class FitCurves {
  static const Curve standard = Curves.easeInOut;
  static const Curve enter = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;
}

// ---------------------------------------------------------------------------
// FitThemeData Extension
// ---------------------------------------------------------------------------

/// Typed theme extension registered on [ThemeData] via `extensions`.
/// Access anywhere via `Theme.of(context).extension<FitThemeData>()!`.
@immutable
class FitThemeData extends ThemeExtension<FitThemeData> {
  final Color background;
  final Color surface;
  final Color elevated;
  final Color accent;
  final Color accentMuted;
  final Color accentGlow;
  final Color success;
  final Color warning;
  final Color error;

  const FitThemeData({
    required this.background,
    required this.surface,
    required this.elevated,
    required this.accent,
    required this.accentMuted,
    required this.accentGlow,
    required this.success,
    required this.warning,
    required this.error,
  });

  /// The default Kinetic Precision dark theme.
  static const kineticPrecision = FitThemeData(
    background: FitColors.obsidian,
    surface: FitColors.obsidianSurface,
    elevated: FitColors.obsidianElevated,
    accent: FitColors.cyberCyan,
    accentMuted: Color(0x1F00E5FF), // 12% alpha
    accentGlow: Color(0x4D00E5FF), // 30% alpha
    success: FitColors.signalGreen,
    warning: FitColors.signalAmber,
    error: FitColors.signalRed,
  );

  @override
  FitThemeData copyWith({
    Color? background,
    Color? surface,
    Color? elevated,
    Color? accent,
    Color? accentMuted,
    Color? accentGlow,
    Color? success,
    Color? warning,
    Color? error,
  }) {
    return FitThemeData(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      elevated: elevated ?? this.elevated,
      accent: accent ?? this.accent,
      accentMuted: accentMuted ?? this.accentMuted,
      accentGlow: accentGlow ?? this.accentGlow,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
    );
  }

  @override
  FitThemeData lerp(FitThemeData? other, double t) {
    if (other is! FitThemeData) return this;
    return FitThemeData(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      elevated: Color.lerp(elevated, other.elevated, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentMuted: Color.lerp(accentMuted, other.accentMuted, t)!,
      accentGlow: Color.lerp(accentGlow, other.accentGlow, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}

/// Convenience extension on [BuildContext] for quick token access.
extension FitThemeX on BuildContext {
  FitThemeData get fitTheme =>
      Theme.of(this).extension<FitThemeData>() ?? FitThemeData.kineticPrecision;
}
