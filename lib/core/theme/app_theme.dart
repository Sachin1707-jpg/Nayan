import 'package:flutter/material.dart';
import 'package:visionmate_ai/core/constants/app_colors.dart';
import 'package:visionmate_ai/core/constants/app_sizes.dart';

/// Application theme configuration optimized for accessibility.
/// 
/// This theme enforces:
/// - WCAG AAA contrast ratios (7:1 or better)
/// - Minimum touch targets (72dp)
/// - High-contrast color scheme
/// - Semantic text scaling
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  /// High-contrast dark theme for accessibility
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: Colors.black, // Text on gold buttons
        onSecondary: Colors.black, // Text on cyan elements
        onSurface: AppColors.textPrimary,
        onError: Colors.black,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.background,

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.primary,
          fontSize: AppSizes.textTitle,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingButton,
            vertical: AppSizes.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          textStyle: const TextStyle(
            fontSize: AppSizes.textButton,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(AppSizes.minTouchTarget, AppSizes.buttonHeightSmall),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingButton,
            vertical: AppSizes.spacingM,
          ),
          textStyle: const TextStyle(
            fontSize: AppSizes.textBody,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingButton,
            vertical: AppSizes.spacingM,
          ),
          side: const BorderSide(
            color: AppColors.primary,
            width: AppSizes.borderMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          textStyle: const TextStyle(
            fontSize: AppSizes.textButton,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          side: const BorderSide(
            color: AppColors.border,
            width: AppSizes.borderThin,
          ),
        ),
        margin: const EdgeInsets.all(AppSizes.spacingM),
      ),

      // Text Theme
      textTheme: const TextTheme(
        // Display styles
        displayLarge: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),

        // Headline styles
        headlineLarge: TextStyle(
          fontSize: AppSizes.textHeadline,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: AppSizes.textTitle,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),

        // Title styles
        titleLarge: TextStyle(
          fontSize: AppSizes.textTitle,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: AppSizes.textBodyLarge,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: AppSizes.textBody,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),

        // Body styles (minimum size for accessibility)
        bodyLarge: TextStyle(
          fontSize: AppSizes.textBodyLarge,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: AppSizes.textBody,
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: AppSizes.textBodyMin,
          color: AppColors.textSecondary,
        ),

        // Label styles
        labelLarge: TextStyle(
          fontSize: AppSizes.textBody,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: AppSizes.textBodyMin,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.primary,
        size: AppSizes.iconM,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: AppSizes.borderThin,
        space: AppSizes.spacingL,
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface,
        contentTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: AppSizes.textBody,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusS),
          side: const BorderSide(
            color: AppColors.primary,
            width: AppSizes.borderMedium,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Focus Theme (for keyboard/screen reader navigation)
      focusColor: AppColors.focusBorder,
    );
  }
}
