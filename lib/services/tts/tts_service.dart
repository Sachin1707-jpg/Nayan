import 'package:flutter_tts/flutter_tts.dart';

/// Text-to-Speech service for voice output
/// Provides accessible audio feedback throughout the app
class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  bool _isSpeaking = false;

  // Default settings
  double _volume = 1.0;
  double _pitch = 1.0;
  double _rate = 0.5;
  String _language = 'en-US';

  /// Initialize TTS engine with default settings
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await _flutterTts.setLanguage(_language);
      await _flutterTts.setVolume(_volume);
      await _flutterTts.setPitch(_pitch);
      await _flutterTts.setSpeechRate(_rate);

      // Set up callbacks
      _flutterTts.setStartHandler(() {
        _isSpeaking = true;
      });

      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
      });

      _flutterTts.setErrorHandler((msg) {
        _isSpeaking = false;
        print('TTS Error: $msg');
      });

      _isInitialized = true;
    } catch (e) {
      print('Failed to initialize TTS: $e');
    }
  }

  /// Speak the given text
  /// If [interrupt] is true, stops current speech before starting
  Future<void> speak(String text, {bool interrupt = true}) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (text.isEmpty) return;

    try {
      if (interrupt && _isSpeaking) {
        await stop();
      }
      await _flutterTts.speak(text);
    } catch (e) {
      print('Failed to speak: $e');
    }
  }

  /// Stop current speech
  Future<void> stop() async {
    if (!_isInitialized) return;

    try {
      await _flutterTts.stop();
      _isSpeaking = false;
    } catch (e) {
      print('Failed to stop TTS: $e');
    }
  }

  /// Pause current speech
  Future<void> pause() async {
    if (!_isInitialized || !_isSpeaking) return;

    try {
      await _flutterTts.pause();
    } catch (e) {
      print('Failed to pause TTS: $e');
    }
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    if (!_isInitialized) await initialize();

    _volume = volume.clamp(0.0, 1.0);
    try {
      await _flutterTts.setVolume(_volume);
    } catch (e) {
      print('Failed to set volume: $e');
    }
  }

  /// Set speech rate (0.0 to 1.0, where 0.5 is normal)
  Future<void> setRate(double rate) async {
    if (!_isInitialized) await initialize();

    _rate = rate.clamp(0.0, 1.0);
    try {
      await _flutterTts.setSpeechRate(_rate);
    } catch (e) {
      print('Failed to set rate: $e');
    }
  }

  /// Set pitch (0.5 to 2.0, where 1.0 is normal)
  Future<void> setPitch(double pitch) async {
    if (!_isInitialized) await initialize();

    _pitch = pitch.clamp(0.5, 2.0);
    try {
      await _flutterTts.setPitch(_pitch);
    } catch (e) {
      print('Failed to set pitch: $e');
    }
  }

  /// Set language
  Future<void> setLanguage(String language) async {
    if (!_isInitialized) await initialize();

    _language = language;
    try {
      await _flutterTts.setLanguage(_language);
    } catch (e) {
      print('Failed to set language: $e');
    }
  }

  /// Get available languages
  Future<List<String>> getLanguages() async {
    if (!_isInitialized) await initialize();

    try {
      final languages = await _flutterTts.getLanguages;
      return languages.cast<String>();
    } catch (e) {
      print('Failed to get languages: $e');
      return ['en-US'];
    }
  }

  /// Check if currently speaking
  bool get isSpeaking => _isSpeaking;

  /// Get current settings
  double get volume => _volume;
  double get rate => _rate;
  double get pitch => _pitch;
  String get language => _language;

  /// Dispose resources
  Future<void> dispose() async {
    await stop();
    _isInitialized = false;
  }
}
