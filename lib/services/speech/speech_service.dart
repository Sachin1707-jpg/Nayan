import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

/// Speech recognition service for voice input
/// Provides speech-to-text conversion with permission handling
class SpeechService {
  static final SpeechService _instance = SpeechService._internal();
  factory SpeechService() => _instance;
  SpeechService._internal();

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isInitialized = false;
  bool _isListening = false;

  /// Initialize speech recognition engine
  /// Returns true if initialization successful
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      // Check microphone permission first
      final permissionStatus = await Permission.microphone.status;
      if (!permissionStatus.isGranted) {
        return false;
      }

      // Initialize speech recognition
      _isInitialized = await _speech.initialize(
        onError: (error) => print('Speech recognition error: ${error.errorMsg}'),
        onStatus: (status) => print('Speech recognition status: $status'),
      );

      return _isInitialized;
    } catch (e) {
      print('Failed to initialize speech recognition: $e');
      return false;
    }
  }

  /// Request microphone permission
  /// Returns true if permission granted
  Future<bool> requestPermission() async {
    try {
      final status = await Permission.microphone.request();
      return status.isGranted;
    } catch (e) {
      print('Failed to request microphone permission: $e');
      return false;
    }
  }

  /// Check if microphone permission is granted
  Future<bool> hasPermission() async {
    try {
      final status = await Permission.microphone.status;
      return status.isGranted;
    } catch (e) {
      print('Failed to check microphone permission: $e');
      return false;
    }
  }

  /// Check if microphone permission is permanently denied
  Future<bool> isPermissionPermanentlyDenied() async {
    try {
      final status = await Permission.microphone.status;
      return status.isPermanentlyDenied;
    } catch (e) {
      print('Failed to check permission status: $e');
      return false;
    }
  }

  /// Open app settings for permission management
  Future<void> openSettings() async {
    try {
      await openAppSettings();
    } catch (e) {
      print('Failed to open settings: $e');
    }
  }

  /// Start listening for speech input
  /// [onResult] callback receives recognized text
  /// [listenFor] maximum listening duration (default 30 seconds)
  /// [pauseFor] pause duration to detect end of speech (default 3 seconds)
  /// [localeId] language locale (default 'en_US')
  Future<bool> startListening({
    required Function(String) onResult,
    Duration listenFor = const Duration(seconds: 30),
    Duration pauseFor = const Duration(seconds: 3),
    String localeId = 'en_US',
  }) async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) return false;
    }

    if (_isListening) {
      await stopListening();
    }

    try {
      await _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            onResult(result.recognizedWords);
          }
        },
        listenOptions: stt.SpeechListenOptions(
          listenFor: listenFor,
          pauseFor: pauseFor,
          localeId: localeId,
          cancelOnError: true,
          partialResults: false,
        ),
      );

      _isListening = true;
      return true;
    } catch (e) {
      print('Failed to start listening: $e');
      _isListening = false;
      return false;
    }
  }

  /// Stop listening for speech input
  Future<void> stopListening() async {
    if (!_isListening) return;

    try {
      await _speech.stop();
      _isListening = false;
    } catch (e) {
      print('Failed to stop listening: $e');
    }
  }

  /// Cancel listening without processing results
  Future<void> cancelListening() async {
    if (!_isListening) return;

    try {
      await _speech.cancel();
      _isListening = false;
    } catch (e) {
      print('Failed to cancel listening: $e');
    }
  }

  /// Check if speech recognition is available on this device
  Future<bool> isAvailable() async {
    try {
      if (!_isInitialized) {
        await initialize();
      }
      return _speech.isAvailable;
    } catch (e) {
      print('Failed to check speech availability: $e');
      return false;
    }
  }

  /// Get list of available locales
  Future<List<stt.LocaleName>> getAvailableLocales() async {
    try {
      if (!_isInitialized) {
        await initialize();
      }
      return await _speech.locales();
    } catch (e) {
      print('Failed to get available locales: $e');
      return [];
    }
  }

  /// Check if currently listening
  bool get isListening => _isListening;

  /// Check if speech recognition is initialized
  bool get isInitialized => _isInitialized;

  /// Get current error message if any
  String? get lastError => _speech.lastError?.errorMsg;

  /// Dispose resources
  Future<void> dispose() async {
    if (_isListening) {
      await stopListening();
    }
    _isInitialized = false;
  }
}
