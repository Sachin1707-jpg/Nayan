import 'package:flutter/material.dart';
import 'package:visionmate_ai/core/constants/app_strings.dart';
import 'package:visionmate_ai/core/theme/app_theme.dart';
import 'package:visionmate_ai/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:visionmate_ai/features/home/presentation/screens/home_screen.dart';
import 'package:visionmate_ai/features/settings/presentation/screens/settings_screen.dart';

/// Root application widget for VisionMate AI.
/// 
/// Configures:
/// - Material theme (high-contrast, accessibility-optimized)
/// - Navigation routes
/// - Global app settings
class VisionMateApp extends StatelessWidget {
  const VisionMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      
      // Use custom high-contrast theme
      theme: AppTheme.darkTheme,
      
      // Initial route - start with welcome screen
      home: const WelcomeScreen(),
      
      // Named routes
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
        // Additional routes will be added as features are implemented
        // '/voice': (context) => const VoiceAssistantScreen(),
        // etc.
      },
    );
  }
}
