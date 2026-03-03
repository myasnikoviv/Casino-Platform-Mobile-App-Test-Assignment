import 'package:casino_platform_test/src/core/theme/app_colors.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Builds the material theme used by the entire application.
abstract final class AppTheme {
  /// Main light theme.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.h1,
        headlineMedium: AppTextStyles.h2,
        bodyMedium: AppTextStyles.body,
        labelMedium: AppTextStyles.label,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
