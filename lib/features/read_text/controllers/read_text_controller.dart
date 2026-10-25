import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../services/camera/camera_service.dart';
import '../../../services/ocr/ocr_service.dart';
import '../../../services/tts/tts_service.dart';
import '../../../services/haptics/haptics_service.dart';

/// Read text feature state
enum ReadTextState {
  idle,
  initializingCamera,
  cameraReady,
  capturingImage,
  processingImage,
  displayingResult,
  speaking,
  permissionDenied,
  error,
}

/// Controller for Read Text feature
/// Manages camera, OCR, and TTS integration
class ReadTextController extends ChangeNotifier {
  final CameraService _cameraService = CameraService();
  final OcrService _ocrService = OcrService();
  final TtsService _ttsService = TtsService();
  final HapticsService _hapticsService = HapticsService();

  ReadTextState _state = ReadTextState.idle;
  String _statusMessage = 'Initializing camera...';
  OcrResult? _lastResult;
  String? _lastError;

  // Callbacks
  Function(String)? onError;
  Function(OcrResult)? onTextExtracted;

  /// Initialize services
  Future<void> initialize() async {
    _updateState(ReadTextState.initializingCamera, 'Checking camera permission...');

    try {
      // Initialize TTS
      await _ttsService.initialize();

      // Initialize OCR
      await _ocrService.initialize();

      // Check camera permission
      final hasPermission = await _cameraService.hasPermission();
      
      if (!hasPermission) {
        _updateState(
          ReadTextState.permissionDenied,
          'Camera permission required to capture images',
        );
        return;
      }

      // Initialize camera
      _updateState(ReadTextState.initializingCamera, 'Initializing camera...');
      final initialized = await _cameraService.initialize();

      if (initialized) {
        _updateState(
          ReadTextState.cameraReady,
          'Camera ready. Tap capture button to take a photo.',
        );
        await _speak('Camera ready. Point at text and tap the capture button.');
      } else {
        _updateState(
          ReadTextState.error,
          'Failed to initialize camera',
        );
      }
    } catch (e) {
      _updateState(
        ReadTextState.error,
        'Initialization failed: $e',
      );
    }
  }

  /// Request camera permission
  Future<void> requestPermission() async {
    try {
      final granted = await _cameraService.requestPermission();
      
      if (granted) {
        await _speak('Camera permission granted. Initializing...');
        await initialize();
      } else {
        final isPermanentlyDenied = await _cameraService.isPermissionPermanentlyDenied();
        
        if (isPermanentlyDenied) {
          _updateState(
            ReadTextState.permissionDenied,
            'Camera permission permanently denied. Please enable in settings.',
          );
          await _speak('Camera permission denied. Please enable it in app settings.');
        } else {
          _updateState(
            ReadTextState.permissionDenied,
            'Camera permission denied',
          );
          await _speak('Camera permission denied.');
        }
      }
    } catch (e) {
      _updateState(
        ReadTextState.error,
        'Failed to request permission: $e',
      );
    }
  }

  /// Open app settings
  Future<void> openSettings() async {
    await _cameraService.openSettings();
  }

  /// Capture image and process with OCR
  Future<void> captureAndProcess() async {
    if (_state == ReadTextState.capturingImage || _state == ReadTextState.processingImage) {
      return; // Already processing
    }

    try {
      // Haptic feedback
      await _hapticsService.medium();

      // Capture image
      _updateState(ReadTextState.capturingImage, 'Capturing image...');
      await _speak('Capturing image...');

      final imagePath = await _cameraService.captureImage();

      if (imagePath == null) {
        _updateState(ReadTextState.cameraReady, 'Failed to capture image. Please try again.');
        await _speak('Failed to capture image. Please try again.');
        await _hapticsService.error();
        return;
      }

      // Process with OCR
      _updateState(ReadTextState.processingImage, 'Processing image with OCR...');
      await _speak('Processing image. Please wait.');

      final result = await _ocrService.processImage(imagePath);
      _lastResult = result;

      // Clean up temporary image
      await _deleteTemporaryImage(imagePath);

      // Handle result
      if (!result.success || result.isEmpty) {
        _updateState(ReadTextState.cameraReady, 'No text found in image.');
        await _speak('No text found in image. Try capturing another photo with better lighting and focus.');
        await _hapticsService.warning();
        
        if (onError != null) {
          onError!('No text detected');
        }
        return;
      }

      // Success
      await _hapticsService.success();
      _updateState(
        ReadTextState.displayingResult,
        'Found ${result.wordCount} words. Reading text...',
      );

      // Notify callback
      if (onTextExtracted != null) {
        onTextExtracted!(result);
      }

      // Read text aloud
      await readTextAloud();

    } catch (e) {
      _updateState(ReadTextState.error, 'Error: $e');
      await _speak('An error occurred while processing the image.');
      await _hapticsService.error();
      
      if (onError != null) {
        onError!(e.toString());
      }
    }
  }

  /// Read extracted text aloud
  Future<void> readTextAloud() async {
    if (_lastResult == null || !_lastResult!.hasText) {
      await _speak('No text to read.');
      return;
    }

    _updateState(ReadTextState.speaking, 'Reading text...');
    
    try {
      // Announce word count first
      final wordCount = _lastResult!.wordCount;
      await _speak('Reading $wordCount ${wordCount == 1 ? "word" : "words"}.');
      
      // Wait a moment
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Read the actual text
      await _speak(_lastResult!.fullText, interrupt: false);
      
      // Return to result display state
      _updateState(ReadTextState.displayingResult, 'Finished reading.');
      
    } catch (e) {
      print('Error reading text aloud: $e');
      _updateState(ReadTextState.displayingResult, 'Error reading text aloud.');
    }
  }

  /// Stop speaking
  Future<void> stopSpeaking() async {
    await _ttsService.stop();
    if (_state == ReadTextState.speaking) {
      _updateState(ReadTextState.displayingResult, 'Stopped reading.');
    }
  }

  /// Capture another image
  Future<void> captureAnother() async {
    await _hapticsService.light();
    _lastResult = null;
    _updateState(ReadTextState.cameraReady, 'Camera ready. Tap capture to take another photo.');
    await _speak('Ready to capture another image.');
  }

  /// Delete temporary image file
  Future<void> _deleteTemporaryImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Failed to delete temporary image: $e');
    }
  }

  /// Speak text using TTS
  Future<void> _speak(String text, {bool interrupt = true}) async {
    try {
      await _ttsService.speak(text, interrupt: interrupt);
    } catch (e) {
      print('TTS error: $e');
    }
  }

  /// Update state and notify listeners
  void _updateState(ReadTextState newState, String statusMessage) {
    _state = newState;
    _statusMessage = statusMessage;
    
    if (newState == ReadTextState.error) {
      _lastError = statusMessage;
      if (onError != null) {
        onError!(statusMessage);
      }
    }
    
    notifyListeners();
  }

  // Getters
  ReadTextState get state => _state;
  String get statusMessage => _statusMessage;
  OcrResult? get lastResult => _lastResult;
  String? get lastError => _lastError;
  CameraService get cameraService => _cameraService;
  
  bool get isIdle => _state == ReadTextState.idle;
  bool get isInitializing => _state == ReadTextState.initializingCamera;
  bool get isCameraReady => _state == ReadTextState.cameraReady;
  bool get isCapturing => _state == ReadTextState.capturingImage;
  bool get isProcessing => _state == ReadTextState.processingImage;
  bool get hasResult => _state == ReadTextState.displayingResult;
  bool get isSpeaking => _state == ReadTextState.speaking;
  bool get hasPermissionIssue => _state == ReadTextState.permissionDenied;
  bool get hasError => _state == ReadTextState.error;
  bool get isBusy => isCapturing || isProcessing;

  @override
  void dispose() {
    _ttsService.stop();
    _cameraService.dispose();
    super.dispose();
  }
}
