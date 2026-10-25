import 'package:flutter/material.dart';
import 'package:visionmate_ai/app.dart';

/// Application entry point.
/// 
/// Initializes the app and delegates to [VisionMateApp].
/// 
/// In future phases, this will:
/// - Initialize services (TTS, logging, analytics)
/// - Set up error handlers
/// - Configure platform-specific settings
void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Initialize services here in future phases
  // - TTS Service
  // - Haptics Service
  // - Logger
  // - Error reporting

  // Run the app
  runApp(const VisionMateApp());
}
