import 'package:flutter/material.dart';
import 'package:visionmate_ai/core/constants/app_colors.dart';
import 'package:visionmate_ai/core/constants/app_sizes.dart';

/// Accessible status indicator for voice interaction state.
/// 
/// Communicates status through:
/// - Text label (primary)
/// - Icon (secondary)
/// - Color (supplementary, not sole indicator)
/// - Semantic announcement for screen readers
class StatusIndicator extends StatelessWidget {
  const StatusIndicator({
    super.key,
    required this.isActive,
    required this.activeLabel,
    required this.inactiveLabel,
    this.activeIcon = Icons.mic,
    this.inactiveIcon = Icons.mic_off,
  });

  /// Whether the status is currently active
  final bool isActive;

  /// Label shown when active
  final String activeLabel;

  /// Label shown when inactive
  final String inactiveLabel;

  /// Icon shown when active
  final IconData activeIcon;

  /// Icon shown when inactive
  final IconData inactiveIcon;

  @override
  Widget build(BuildContext context) {
    final label = isActive ? activeLabel : inactiveLabel;
    final icon = isActive ? activeIcon : inactiveIcon;
    final color = isActive ? AppColors.success : AppColors.textSecondary;

    return Semantics(
      label: 'Status: $label',
      liveRegion: true, // Announces changes automatically
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingL,
          vertical: AppSizes.spacingM,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          border: Border.all(
            color: isActive ? AppColors.success : AppColors.border,
            width: AppSizes.borderMedium,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: AppSizes.iconM,
              semanticLabel: '', // Label is on parent
            ),
            const SizedBox(width: AppSizes.spacingM),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
