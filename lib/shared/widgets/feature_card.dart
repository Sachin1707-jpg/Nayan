import 'package:flutter/material.dart';
import 'package:visionmate_ai/core/constants/app_colors.dart';
import 'package:visionmate_ai/core/constants/app_sizes.dart';

/// Accessible feature card for home screen actions.
/// 
/// Large, tappable card with:
/// - Icon and label for recognition
/// - High-contrast borders
/// - Semantic labels for screen readers
/// - Minimum 72dp touch target
class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.semanticLabel,
    this.semanticHint,
  });

  /// Icon representing the feature
  final IconData icon;

  /// Label text
  final String label;

  /// Callback when tapped
  final VoidCallback onTap;

  /// Optional semantic label (defaults to label)
  final String? semanticLabel;

  /// Optional semantic hint for screen readers
  final String? semanticHint;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      hint: semanticHint ?? 'Double tap to activate',
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          child: Container(
            height: AppSizes.minTouchTarget * 1.5, // 108dp minimum
            padding: const EdgeInsets.all(AppSizes.spacingM),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              border: Border.all(
                color: AppColors.border,
                width: AppSizes.borderMedium,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: AppSizes.iconL,
                  color: AppColors.primary,
                  semanticLabel: '', // Label is on parent
                ),
                const SizedBox(height: AppSizes.spacingS),
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
