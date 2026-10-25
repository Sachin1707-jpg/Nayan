import 'package:flutter/material.dart';
import 'package:visionmate_ai/core/constants/app_colors.dart';
import 'package:visionmate_ai/core/constants/app_sizes.dart';
import 'package:visionmate_ai/core/constants/app_strings.dart';
import 'package:visionmate_ai/services/tts/tts_service.dart';
import 'package:visionmate_ai/services/haptics/haptics_service.dart';

/// Settings screen for accessibility and app preferences
/// 
/// Allows users to configure:
/// - Voice speed, volume, and pitch
/// - Haptic feedback intensity
/// - Language preferences
/// 
/// All settings are accessible with screen readers
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TtsService _tts = TtsService();
  final HapticsService _haptics = HapticsService();

  late double _voiceSpeed;
  late double _voiceVolume;
  late double _voicePitch;
  late bool _hapticsEnabled;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    setState(() {
      _voiceSpeed = _tts.rate;
      _voiceVolume = _tts.volume;
      _voicePitch = _tts.pitch;
      _hapticsEnabled = _haptics.isEnabled;
    });
  }

  Future<void> _updateVoiceSpeed(double value) async {
    await _tts.setRate(value);
    await _haptics.selection();
    setState(() {
      _voiceSpeed = value;
    });
  }

  Future<void> _updateVoiceVolume(double value) async {
    await _tts.setVolume(value);
    await _haptics.selection();
    setState(() {
      _voiceVolume = value;
    });
  }

  Future<void> _updateVoicePitch(double value) async {
    await _tts.setPitch(value);
    await _haptics.selection();
    setState(() {
      _voicePitch = value;
    });
  }

  Future<void> _toggleHaptics(bool value) async {
    _haptics.setEnabled(value);
    if (value) {
      await _haptics.medium();
    }
    await _tts.speak(value ? 'Haptic feedback enabled' : 'Haptic feedback disabled');
    setState(() {
      _hapticsEnabled = value;
    });
  }

  Future<void> _testVoice() async {
    await _haptics.light();
    await _tts.speak(
      'This is a test of the current voice settings. The speed is ${(_voiceSpeed * 100).round()} percent.',
      interrupt: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.featureSettings),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.paddingScreen),
          children: [
            // Voice Settings Section
            Text(
              'Voice Settings',
              style: Theme.of(context).textTheme.headlineSmall,
              semanticsLabel: 'Voice Settings Section',
            ),
            const SizedBox(height: AppSizes.spacingL),

            // Voice Speed
            _buildSliderSetting(
              label: 'Voice Speed',
              semanticLabel: 'Voice speed slider',
              value: _voiceSpeed,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              onChanged: _updateVoiceSpeed,
              valueLabel: '${(_voiceSpeed * 100).round()}%',
            ),

            const SizedBox(height: AppSizes.spacingL),

            // Voice Volume
            _buildSliderSetting(
              label: 'Voice Volume',
              semanticLabel: 'Voice volume slider',
              value: _voiceVolume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              onChanged: _updateVoiceVolume,
              valueLabel: '${(_voiceVolume * 100).round()}%',
            ),

            const SizedBox(height: AppSizes.spacingL),

            // Voice Pitch
            _buildSliderSetting(
              label: 'Voice Pitch',
              semanticLabel: 'Voice pitch slider',
              value: _voicePitch,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              onChanged: _updateVoicePitch,
              valueLabel: _voicePitch.toStringAsFixed(1),
            ),

            const SizedBox(height: AppSizes.spacingM),

            // Test Voice Button
            ElevatedButton.icon(
              onPressed: _testVoice,
              icon: const Icon(
                Icons.play_arrow,
                size: AppSizes.iconL,
              ),
              label: Text(
                'Test Voice',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
              ),
            ),

            const SizedBox(height: AppSizes.spacingXL),

            // Haptic Settings Section
            Text(
              'Haptic Feedback',
              style: Theme.of(context).textTheme.headlineSmall,
              semanticsLabel: 'Haptic Feedback Section',
            ),
            const SizedBox(height: AppSizes.spacingL),

            // Haptics Toggle
            SwitchListTile(
              title: Text(
                'Enable Haptic Feedback',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'Vibration feedback for button presses',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: _hapticsEnabled,
              onChanged: _toggleHaptics,
              tileColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingCard,
                vertical: AppSizes.spacingS,
              ),
            ),

            const SizedBox(height: AppSizes.spacingXL),

            // About Section
            Text(
              'About',
              style: Theme.of(context).textTheme.headlineSmall,
              semanticsLabel: 'About Section',
            ),
            const SizedBox(height: AppSizes.spacingL),

            _buildInfoCard(
              icon: Icons.info_outline,
              title: 'VisionMate AI',
              subtitle: 'Version 1.0.0',
            ),

            const SizedBox(height: AppSizes.spacingM),

            _buildInfoCard(
              icon: Icons.accessibility_new,
              title: 'Accessibility',
              subtitle: 'WCAG AAA Compliant',
            ),

            const SizedBox(height: AppSizes.spacingL),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderSetting({
    required String label,
    required String semanticLabel,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Function(double) onChanged,
    required String valueLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              valueLabel,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                  ),
              semanticsLabel: '$label value: $valueLabel',
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spacingS),
        Semantics(
          label: semanticLabel,
          value: valueLabel,
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.primary,
          size: AppSizes.iconL,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        contentPadding: EdgeInsets.all(AppSizes.paddingCard),
      ),
    );
  }
}
