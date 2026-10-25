import 'package:flutter/material.dart';
import 'package:visionmate_ai/core/constants/app_sizes.dart';

/// Accessible button component optimized for blind and low-vision users.
/// 
/// Features:
/// - Minimum 72dp touch target (exceeds WCAG AAA)
/// - Explicit semantic labels for screen readers
/// - High-contrast styling
/// - Optional haptic feedback
/// - Configurable size variants
class AccessibleButton extends StatelessWidget {
  /// Creates an accessible elevated button with primary styling
  const AccessibleButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.semanticLabel,
    this.semanticHint,
    this.icon,
    this.height = AppSizes.buttonHeight,
    this.fullWidth = true,
    this.isLoading = false,
  });

  /// Button text label
  final String label;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Optional semantic label for screen readers
  /// If not provided, [label] is used
  final String? semanticLabel;

  /// Optional semantic hint for screen readers
  /// Provides additional context about the button's action
  final String? semanticHint;

  /// Optional leading icon
  final IconData? icon;

  /// Button height (defaults to 72dp)
  final double height;

  /// Whether button should expand to full width
  final bool fullWidth;

  /// Whether button is in loading state
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      hint: semanticHint ?? 'Double tap to activate',
      enabled: onPressed != null && !isLoading,
      child: SizedBox(
        width: fullWidth ? double.infinity : null,
        height: height,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? const SizedBox(
                  width: AppSizes.iconM,
                  height: AppSizes.iconM,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              : Row(
                  mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: AppSizes.iconM),
                      const SizedBox(width: AppSizes.spacingM),
                    ],
                    Text(label),
                  ],
                ),
        ),
      ),
    );
  }
}

/// Accessible outlined button variant
class AccessibleOutlinedButton extends StatelessWidget {
  /// Creates an accessible outlined button
  const AccessibleOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.semanticLabel,
    this.icon,
    this.height = AppSizes.buttonHeight,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final IconData? icon;
  final double height;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      hint: 'Double tap to activate',
      enabled: onPressed != null,
      child: SizedBox(
        width: fullWidth ? double.infinity : null,
        height: height,
        child: OutlinedButton(
          onPressed: onPressed,
          child: Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppSizes.iconM),
                const SizedBox(width: AppSizes.spacingM),
              ],
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

/// Accessible text button variant (for secondary actions)
class AccessibleTextButton extends StatelessWidget {
  /// Creates an accessible text button
  const AccessibleTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.semanticLabel,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      hint: 'Double tap to activate',
      enabled: onPressed != null,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: AppSizes.iconM),
              const SizedBox(width: AppSizes.spacingS),
            ],
            Text(label),
          ],
        ),
      ),
    );
  }
}
