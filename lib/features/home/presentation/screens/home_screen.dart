import 'package:flutter/material.dart';
import 'package:visionmate_ai/core/constants/app_colors.dart';
import 'package:visionmate_ai/core/constants/app_sizes.dart';
import 'package:visionmate_ai/core/constants/app_strings.dart';
import 'package:visionmate_ai/shared/widgets/accessible_button.dart';
import 'package:visionmate_ai/shared/widgets/feature_card.dart';
import 'package:visionmate_ai/shared/widgets/status_indicator.dart';
import 'package:visionmate_ai/services/tts/tts_service.dart';
import 'package:visionmate_ai/services/haptics/haptics_service.dart';
import 'package:visionmate_ai/services/voice/voice_assistant_controller.dart';
import 'package:visionmate_ai/services/voice/voice_command_processor.dart';
import 'package:visionmate_ai/features/home/presentation/screens/placeholder_screen.dart';
import 'package:visionmate_ai/features/read_text/presentation/screens/read_text_screen.dart';

/// Home screen - Main navigation hub for VisionMate AI.
/// 
/// Provides access to all features through large, accessible cards.
/// Shows voice interaction status prominently.
/// 
/// Accessibility features:
/// - Screen reader optimized layout
/// - Large touch targets (72dp+)
/// - High contrast visuals
/// - Semantic labels and hints
/// - Status announced via live region
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VoiceAssistantController _voiceController;
  final TtsService _tts = TtsService();
  final HapticsService _haptics = HapticsService();

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    // Initialize voice assistant
    _voiceController = VoiceAssistantController();
    
    // Set up command handler
    _voiceController.onCommandRecognized = _handleVoiceCommand;
    
    // Set up error handler
    _voiceController.onError = (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red.shade900,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    };
    
    // Listen to state changes
    _voiceController.addListener(_onVoiceStateChanged);
    
    // Initialize
    await _voiceController.initialize();
    
    // Announce home screen
    await Future.delayed(const Duration(milliseconds: 500));
    await _tts.speak('Home screen. ${_voiceController.statusMessage}');
  }

  void _onVoiceStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _voiceController.removeListener(_onVoiceStateChanged);
    _voiceController.dispose();
    _tts.stop();
    super.dispose();
  }

  Future<void> _toggleVoiceListening() async {
    await _haptics.medium();
    
    if (_voiceController.isListening) {
      // Stop listening
      await _voiceController.stopListening();
    } else if (_voiceController.hasPermissionIssue) {
      // Request permission
      await _voiceController.requestPermission();
    } else {
      // Start listening
      await _voiceController.startListening();
    }
  }

  void _handleVoiceCommand(CommandType command) {
    // Handle the recognized command
    switch (command) {
      case CommandType.readText:
        _navigateToReadText();
        break;
      case CommandType.describeSurroundings:
        _navigateToFeature(AppStrings.featureDescribeScene);
        break;
      case CommandType.navigate:
        _navigateToFeature(AppStrings.featureNavigation);
        break;
      case CommandType.news:
      case CommandType.music:
        _navigateToFeature(AppStrings.featureNewsMusic);
        break;
      case CommandType.callContact:
        _navigateToFeature(AppStrings.featureContacts);
        break;
      case CommandType.stop:
        // Already handled by controller
        break;
      case CommandType.unknown:
        // Already handled by controller
        break;
    }
  }

  Future<void> _navigateToFeature(String featureName) async {
    await _haptics.light();
    
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceholderScreen(featureName: featureName),
        ),
      );
    }
  }

  Future<void> _navigateToReadText() async {
    await _haptics.light();
    
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ReadTextScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homeTitle),
        centerTitle: true,
        actions: [
          // Help button for voice commands
          if (_voiceController.isIdle)
            IconButton(
              icon: const Icon(Icons.help_outline),
              tooltip: 'Voice commands help',
              onPressed: () async {
                await _haptics.light();
                await _voiceController.announceHelp();
              },
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.paddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App branding
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.visibility,
                      size: AppSizes.iconXL,
                      color: AppColors.primary,
                      semanticLabel: AppStrings.semanticLogo,
                    ),
                    const SizedBox(height: AppSizes.spacingM),
                    Text(
                      AppStrings.homeWelcome,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.spacingXL),

              // Voice status indicator with state-specific labels
              Center(
                child: StatusIndicator(
                  isActive: _voiceController.isListening,
                  activeLabel: _getStatusLabel(),
                  inactiveLabel: _getStatusLabel(),
                ),
              ),

              const SizedBox(height: AppSizes.spacingM),

              // Status message
              Center(
                child: Semantics(
                  liveRegion: true,
                  child: Text(
                    _voiceController.statusMessage,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: _getStatusColor(),
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.spacingL),

              // Voice assistant button (primary action)
              AccessibleButton(
                label: _getVoiceButtonLabel(),
                semanticLabel: _getVoiceButtonLabel(),
                semanticHint: _getVoiceButtonHint(),
                icon: _getVoiceButtonIcon(),
                onPressed: _voiceController.isBusy ? null : _toggleVoiceListening,
                height: AppSizes.buttonHeightLarge,
              ),

              // Cancel button (shown when busy)
              if (_voiceController.isBusy) ...[
                const SizedBox(height: AppSizes.spacingM),
                AccessibleButton(
                  label: 'Cancel',
                  semanticLabel: 'Cancel voice interaction',
                  semanticHint: 'Double tap to cancel',
                  icon: Icons.cancel,
                  onPressed: () async {
                    await _haptics.light();
                    await _voiceController.cancel();
                  },
                  height: AppSizes.buttonHeight,
                ),
              ],

              // Open settings button (shown when permission denied)
              if (_voiceController.hasPermissionIssue) ...[
                const SizedBox(height: AppSizes.spacingM),
                AccessibleButton(
                  label: 'Open Settings',
                  semanticLabel: 'Open app settings',
                  semanticHint: 'Double tap to enable microphone permission',
                  icon: Icons.settings,
                  onPressed: () async {
                    await _haptics.light();
                    await _voiceController.openSettings();
                  },
                  height: AppSizes.buttonHeight,
                ),
              ],

              const SizedBox(height: AppSizes.spacingXL),

              // Feature grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: AppSizes.spacingM,
                crossAxisSpacing: AppSizes.spacingM,
                childAspectRatio: 1.0,
                children: [
                  // Read Text
                  FeatureCard(
                    icon: Icons.document_scanner,
                    label: AppStrings.featureReadText,
                    semanticHint: AppStrings.featureReadTextHint,
                    onTap: _navigateToReadText,
                  ),

                  // Describe Surroundings
                  FeatureCard(
                    icon: Icons.camera_alt,
                    label: AppStrings.featureDescribeScene,
                    semanticHint: AppStrings.featureDescribeSceneHint,
                    onTap: () => _navigateToFeature(AppStrings.featureDescribeScene),
                  ),

                  // Navigation
                  FeatureCard(
                    icon: Icons.navigation,
                    label: AppStrings.featureNavigation,
                    semanticHint: AppStrings.featureNavigationHint,
                    onTap: () => _navigateToFeature(AppStrings.featureNavigation),
                  ),

                  // News and Music
                  FeatureCard(
                    icon: Icons.headphones,
                    label: AppStrings.featureNewsMusic,
                    semanticHint: AppStrings.featureNewsMusicHint,
                    onTap: () => _navigateToFeature(AppStrings.featureNewsMusic),
                  ),

                  // Trusted Contacts
                  FeatureCard(
                    icon: Icons.contacts,
                    label: AppStrings.featureContacts,
                    semanticHint: AppStrings.featureContactsHint,
                    onTap: () => _navigateToFeature(AppStrings.featureContacts),
                  ),

                  // Settings
                  FeatureCard(
                    icon: Icons.settings,
                    label: AppStrings.featureSettings,
                    semanticHint: AppStrings.featureSettingsHint,
                    onTap: () async {
                      await _haptics.light();
                      await _tts.speak('Opening Settings');
                      if (mounted) {
                        Navigator.pushNamed(context, '/settings');
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.spacingL),
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusLabel() {
    switch (_voiceController.state) {
      case VoiceAssistantState.idle:
        return 'Ready';
      case VoiceAssistantState.listening:
        return 'Listening';
      case VoiceAssistantState.processing:
        return 'Processing';
      case VoiceAssistantState.speaking:
        return 'Speaking';
      case VoiceAssistantState.permissionDenied:
        return 'Permission Required';
      case VoiceAssistantState.error:
        return 'Error';
    }
  }

  Color _getStatusColor() {
    switch (_voiceController.state) {
      case VoiceAssistantState.idle:
        return AppColors.textSecondary;
      case VoiceAssistantState.listening:
        return AppColors.primary;
      case VoiceAssistantState.processing:
        return AppColors.primary;
      case VoiceAssistantState.speaking:
        return AppColors.primary;
      case VoiceAssistantState.permissionDenied:
        return Colors.orange;
      case VoiceAssistantState.error:
        return Colors.red;
    }
  }

  String _getVoiceButtonLabel() {
    if (_voiceController.hasPermissionIssue) {
      return 'Grant Microphone Permission';
    }
    if (_voiceController.isListening) {
      return 'Stop Listening';
    }
    return 'Start Voice Command';
  }

  String _getVoiceButtonHint() {
    if (_voiceController.hasPermissionIssue) {
      return 'Double tap to request microphone permission';
    }
    if (_voiceController.isListening) {
      return 'Double tap to stop listening';
    }
    return 'Double tap to start listening for voice commands';
  }

  IconData _getVoiceButtonIcon() {
    if (_voiceController.hasPermissionIssue) {
      return Icons.mic_off;
    }
    if (_voiceController.isListening) {
      return Icons.mic;
    }
    return Icons.mic_none;
  }
}
