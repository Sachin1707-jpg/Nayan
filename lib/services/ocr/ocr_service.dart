import 'dart:ui';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart' as mlkit;

/// OCR service for text recognition from images
/// Uses Google ML Kit for on-device text recognition
class OcrService {
  static final OcrService _instance = OcrService._internal();
  factory OcrService() => _instance;
  OcrService._internal();

  late final mlkit.TextRecognizer _textRecognizer;
  bool _isInitialized = false;

  /// Initialize OCR engine
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize text recognizer for Latin script
      _textRecognizer = mlkit.TextRecognizer(script: mlkit.TextRecognitionScript.latin);
      _isInitialized = true;
    } catch (e) {
      print('Failed to initialize OCR: $e');
      _isInitialized = false;
    }
  }

  /// Process image and extract text
  /// Returns extracted text or null if processing fails
  Future<OcrResult> processImage(String imagePath) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final inputImage = mlkit.InputImage.fromFilePath(imagePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      // Extract full text
      final fullText = recognizedText.text.trim();

      // Extract text blocks for detailed information
      final blocks = recognizedText.blocks.map((block) {
        return OcrTextBlock(
          text: block.text,
          confidence: _calculateConfidence(block),
          boundingBox: block.boundingBox,
        );
      }).toList();

      return OcrResult(
        fullText: fullText,
        blocks: blocks,
        success: fullText.isNotEmpty,
        isEmpty: fullText.isEmpty,
      );
    } catch (e) {
      print('Failed to process image: $e');
      return OcrResult(
        fullText: '',
        blocks: [],
        success: false,
        isEmpty: true,
        error: e.toString(),
      );
    }
  }

  /// Calculate confidence score for a text block (0.0 to 1.0)
  /// ML Kit doesn't provide confidence directly, so we use heuristics
  double _calculateConfidence(mlkit.TextBlock block) {
    // Basic heuristic: longer text with more characters likely more reliable
    final length = block.text.length;
    if (length > 50) return 0.9;
    if (length > 20) return 0.8;
    if (length > 10) return 0.7;
    if (length > 5) return 0.6;
    return 0.5;
  }

  /// Check if OCR is available
  bool get isAvailable => _isInitialized;

  /// Dispose OCR resources
  Future<void> dispose() async {
    if (_isInitialized) {
      await _textRecognizer.close();
      _isInitialized = false;
    }
  }
}

/// OCR result containing extracted text and metadata
class OcrResult {
  final String fullText;
  final List<OcrTextBlock> blocks;
  final bool success;
  final bool isEmpty;
  final String? error;

  OcrResult({
    required this.fullText,
    required this.blocks,
    required this.success,
    required this.isEmpty,
    this.error,
  });

  /// Get character count
  int get characterCount => fullText.length;

  /// Get word count
  int get wordCount => fullText.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;

  /// Get line count
  int get lineCount => fullText.split('\n').length;

  /// Check if result has text
  bool get hasText => fullText.isNotEmpty;
}

/// Text block with position and confidence
class OcrTextBlock {
  final String text;
  final double confidence;
  final Rect boundingBox;

  OcrTextBlock({
    required this.text,
    required this.confidence,
    required this.boundingBox,
  });
}
