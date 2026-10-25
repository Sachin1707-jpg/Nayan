import 'package:flutter/material.dart';
import 'package:visionmate_ai/core/constants/app_colors.dart';
import 'package:visionmate_ai/core/constants/app_sizes.dart';
import 'package:visionmate_ai/core/constants/app_strings.dart';
import 'package:visionmate_ai/shared/widgets/accessible_button.dart';

/// Placeholder screen for features under development.
/// 
/// Provides clear feedback that the feature is coming soon
/// with easy navigation back to home.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.featureName,
  });

  final String featureName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(featureName),
        leading: Semantics(
          button: true,
          label: AppStrings.actionBack,
          hint: 'Double tap to return to home screen',
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            tooltip: AppStrings.actionBack,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingScreen),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Feature icon
              Icon(
                Icons.construction,
                size: AppSizes.iconXXL,
                color: AppColors.warning,
                semanticLabel: 'Under construction',
              ),

              const SizedBox(height: AppSizes.spacingXL),

              // Feature name
              Text(
                featureName,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSizes.spacingL),

              // Coming soon message
              Text(
                AppStrings.placeholderFeature,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSizes.spacingXXL),

              // Back button
              AccessibleButton(
                label: AppStrings.actionBack,
                semanticLabel: 'Back to home',
                semanticHint: 'Double tap to return to home screen',
                icon: Icons.home,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
