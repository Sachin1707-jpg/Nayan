import 'package:flutter/foundation.dart';
import '../speech/speech_service.dart';
import '../tts/tts_service.dart';
import 'voice_command_processor.dart';

/// Voice assistant state
enum VoiceAssistantState {
  idle,
  listening,
  processing,
  speaking,
  permissionDenied,
  error,
}

/// Voice assistant controller
/// Manages speech recognition, command processing, and TTS responses
class VoiceAssistantController extends ChangeNotifier {
  final SpeechService _speechService = SpeechService();
  final TtsService _ttsService = TtsService();

  VoiceAssistantState _state = VoiceAssistantState.idle;
  String _statusMessage = 'Voice assistant is ready';
  String? _lastRecognizedText;
  String? _lastError;
  CommandType? _lastCommand;

  // Callbacks for command execution
  Function(CommandType)? onCommandRecognized;
  Function(String)? onError;

  /// Initialize services
  Future<void> initialize() async {
    try {
      await _ttsService.initialize();
      
      final hasPermission = await _speechService.hasPermission();
      if (!hasPermission) {
        _updateState(
          VoiceAssistantState.permissionDenied,
          'Microphone permission required for voice interaction',
        );
      } else {
        final initialized = await _speechService.initialize();
        if (initialized) {
          _updateState(
            VoiceAssistantState.idle,
            'Voice assistant is ready. Tap the microphone to speak.',
          );
        } else {
          _updateState(
            VoiceAssistantState.error,
            'Speech recognition is not available on this device',
          );
        }
      }
    } catch (e) {
      _updateState(
        VoiceAssistantState.error,
        'Failed to initialize voice assistant: $e',
      );
    }
  }

  /// Request microphone permission
  Future<void> requestPermission() async {
    try {
      final granted = await _speechService.requestPermission();
      
      if (granted) {
        await initialize();
        await _speak('Microphone permission granted. You can now use voice commands.');
      } else {
        final isPermanentlyDenied = await _speechService.isPermissionPermanentlyDenied();
        
        if (isPermanentlyDenied) {
          _updateState(
            VoiceAssistantState.permissionDenied,
            'Microphone permission is permanently denied. Please enable it in settings.',
          );
          await _speak('Microphone permission denied. Please enable it in app settings.');
        } else {
          _updateState(
            VoiceAssistantState.permissionDenied,
            'Microphone permission denied. Voice commands will not work.',
          );
          await _speak('Microphone permission denied.');
        }
      }
    } catch (e) {
      _updateState(
        VoiceAssistantState.error,
        'Failed to request permission: $e',
      );
    }
  }

  /// Open app settings for permission management
  Future<void> openSettings() async {
    await _speechService.openSettings();
  }

  /// Start listening for voice commands
  Future<void> startListening() async {
    if (_state == VoiceAssistantState.permissionDenied) {
      await requestPermission();
      return;
    }

    if (_state == VoiceAssistantState.listening) {
      return; // Already listening
    }

    // Stop any ongoing speech
    await _ttsService.stop();

    _updateState(VoiceAssistantState.listening, 'Listening... Speak your command.');
    
    try {
      final success = await _speechService.startListening(
        onResult: _handleSpeechResult,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
      );

      if (!success) {
        _updateState(
          VoiceAssistantState.error,
          'Failed to start listening. Please check microphone access.',
        );
        await _speak('Failed to start listening.');
      }
    } catch (e) {
      _updateState(
        VoiceAssistantState.error,
        'Error starting voice recognition: $e',
      );
      await _speak('Error starting voice recognition.');
    }
  }

  /// Stop listening for voice commands
  Future<void> stopListening() async {
    if (_state != VoiceAssistantState.listening) {
      return;
    }

    await _speechService.stopListening();
    _updateState(VoiceAssistantState.idle, 'Voice assistant stopped.');
    await _speak('Voice assistant stopped.');
  }

  /// Handle speech recognition result
  Future<void> _handleSpeechResult(String recognizedText) async {
    if (recognizedText.isEmpty) {
      _updateState(
        VoiceAssistantState.idle,
        'No speech detected. Please try again.',
      );
      await _speak('I did not hear anything. Please try again.');
      return;
    }

    _lastRecognizedText = recognizedText;
    _updateState(
      VoiceAssistantState.processing,
      'Processing: "$recognizedText"',
    );

    // Process the command
    final result = VoiceCommandProcessor.processCommand(recognizedText);
    _lastCommand = result.type;

    if (result.isUnknown) {
      _updateState(
        VoiceAssistantState.speaking,
        'Command not recognized: "$recognizedText"',
      );
      await _speak(
        'I did not understand "$recognizedText". ${VoiceCommandProcessor.getHelpMessage()}',
      );
      _updateState(VoiceAssistantState.idle, 'Ready for next command.');
    } else {
      _updateState(
        VoiceAssistantState.speaking,
        'Executing: ${VoiceCommandProcessor.getCommandName(result.type)}',
      );
      
      // Speak response
      final response = VoiceCommandProcessor.getCommandResponse(result.type);
      await _speak(response);

      // Execute command callback
      if (onCommandRecognized != null) {
        onCommandRecognized!(result.type);
      }

      // Handle stop command
      if (result.type == CommandType.stop) {
        _updateState(VoiceAssistantState.idle, 'Voice assistant stopped.');
      } else {
        _updateState(VoiceAssistantState.idle, 'Command executed. Ready for next command.');
      }
    }
  }

  /// Speak text using TTS
  Future<void> _speak(String text) async {
    try {
      await _ttsService.speak(text, interrupt: true);
    } catch (e) {
      print('TTS error: $e');
    }
  }

  /// Update state and notify listeners
  void _updateState(VoiceAssistantState newState, String statusMessage) {
    _state = newState;
    _statusMessage = statusMessage;
    
    if (newState == VoiceAssistantState.error) {
      _lastError = statusMessage;
      if (onError != null) {
        onError!(statusMessage);
      }
    }
    
    notifyListeners();
  }

  /// Announce help message
  Future<void> announceHelp() async {
    await _speak(VoiceCommandProcessor.getHelpMessage());
  }

  /// Cancel current operation
  Future<void> cancel() async {
    if (_state == VoiceAssistantState.listening) {
      await _speechService.cancelListening();
    }
    await _ttsService.stop();
    _updateState(VoiceAssistantState.idle, 'Operation cancelled.');
  }

  // Getters
  VoiceAssistantState get state => _state;
  String get statusMessage => _statusMessage;
  String? get lastRecognizedText => _lastRecognizedText;
  String? get lastError => _lastError;
  CommandType? get lastCommand => _lastCommand;
  
  bool get isIdle => _state == VoiceAssistantState.idle;
  bool get isListening => _state == VoiceAssistantState.listening;
  bool get isProcessing => _state == VoiceAssistantState.processing;
  bool get isSpeaking => _state == VoiceAssistantState.speaking;
  bool get hasPermissionIssue => _state == VoiceAssistantState.permissionDenied;
  bool get hasError => _state == VoiceAssistantState.error;
  bool get isBusy => isListening || isProcessing || isSpeaking;

  @override
  void dispose() {
    _speechService.dispose();
    _ttsService.dispose();
    super.dispose();
  }
}
