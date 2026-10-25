import 'package:flutter/services.dart';

/// Haptic feedback service for tactile responses
/// Provides vibration feedback for UI interactions
class HapticsService {
  static final HapticsService _instance = HapticsService._internal();
  factory HapticsService() => _instance;
  HapticsService._internal();

  bool _isEnabled = true;

  /// Light impact feedback (e.g., button tap)
  Future<void> light() async {
    if (!_isEnabled) return;
    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      print('Haptic light impact failed: $e');
    }
  }

  /// Medium impact feedback (e.g., toggle switch)
  Future<void> medium() async {
    if (!_isEnabled) return;
    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      print('Haptic medium impact failed: $e');
    }
  }

  /// Heavy impact feedback (e.g., important action)
  Future<void> heavy() async {
    if (!_isEnabled) return;
    try {
      await HapticFeedback.heavyImpact();
    } catch (e) {
      print('Haptic heavy impact failed: $e');
    }
  }

  /// Selection feedback (e.g., scrolling through items)
  Future<void> selection() async {
    if (!_isEnabled) return;
    try {
      await HapticFeedback.selectionClick();
    } catch (e) {
      print('Haptic selection failed: $e');
    }
  }

  /// Vibrate feedback (Android standard vibration)
  Future<void> vibrate() async {
    if (!_isEnabled) return;
    try {
      await HapticFeedback.vibrate();
    } catch (e) {
      print('Haptic vibrate failed: $e');
    }
  }

  /// Success pattern (double light tap)
  Future<void> success() async {
    if (!_isEnabled) return;
    await light();
    await Future.delayed(const Duration(milliseconds: 100));
    await light();
  }

  /// Error pattern (heavy vibration)
  Future<void> error() async {
    if (!_isEnabled) return;
    await heavy();
  }

  /// Warning pattern (medium vibration)
  Future<void> warning() async {
    if (!_isEnabled) return;
    await medium();
  }

  /// Enable or disable haptic feedback
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Check if haptics are enabled
  bool get isEnabled => _isEnabled;
}
