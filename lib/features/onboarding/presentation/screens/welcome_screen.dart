import 'package:flutter/material.dart';
import 'package:visionmate_ai/core/constants/app_colors.dart';
import 'package:visionmate_ai/core/constants/app_sizes.dart';
import 'package:visionmate_ai/core/constants/app_strings.dart';
import 'package:visionmate_ai/shared/widgets/accessible_button.dart';

/// Welcome screen - First screen users see when opening the app.
/// 
/// Optimized for accessibility with:
/// - High-contrast visuals
/// - Large touch targets
/// - Clear semantic labels
/// - Simple, predictable layout
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingScreen),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Logo/Icon
                const Icon(
                  Icons.visibility,
                  size: AppSizes.iconXXL,
                  color: AppColors.primary,
                  semanticLabel: AppStrings.semanticLogo,
                ),
                
                const SizedBox(height: AppSizes.spacingXL),
                
                // App Title
                Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: AppSizes.textHeadline,
                  ),
                  textAlign: TextAlign.center,
                  semanticsLabel: AppStrings.appName,
                ),
                
                const SizedBox(height: AppSizes.spacingM),
                
                // Subtitle
                Text(
                  AppStrings.appTagline,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: AppSizes.textBody,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppSizes.spacingXXL),
                
                // Start Button - Using AccessibleButton component
                AccessibleButton(
                  label: AppStrings.actionStart,
                  semanticLabel: AppStrings.semanticButtonStart,
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    // Navigate to home screen
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
                
                const SizedBox(height: AppSizes.spacingL),
                
                // Information text
                Text(
                  AppStrings.appDescription,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textDisabled,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
