import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Builds the material theme used by the entire application.
abstract final class CPAppTheme {
  /// Main light theme.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: CPAppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CPAppColors.primary,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        headlineLarge: CPAppTextStyles.h1,
        headlineMedium: CPAppTextStyles.h2,
        bodyMedium: CPAppTextStyles.body,
        labelMedium: CPAppTextStyles.label,
      ),
      cardTheme: CardThemeData(
        color: CPAppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CPAppColors.background,
        foregroundColor: CPAppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
