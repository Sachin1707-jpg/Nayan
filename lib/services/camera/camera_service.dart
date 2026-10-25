import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

/// Camera service for capturing images
/// Provides camera initialization, permission handling, and image capture
class CameraService {
  static final CameraService _instance = CameraService._internal();
  factory CameraService() => _instance;
  CameraService._internal();

  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;

  /// Initialize camera with back camera
  Future<bool> initialize() async {
    if (_isInitialized && _controller != null) {
      return true;
    }

    try {
      // Check camera permission
      final hasPermission = await Permission.camera.isGranted;
      if (!hasPermission) {
        return false;
      }

      // Get available cameras
      _cameras = await availableCameras();
      
      if (_cameras == null || _cameras!.isEmpty) {
        print('No cameras available');
        return false;
      }

      // Use back camera (index 0 is typically back camera)
      final backCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras!.first,
      );

      // Create controller
      _controller = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      // Initialize controller
      await _controller!.initialize();
      _isInitialized = true;

      return true;
    } catch (e) {
      print('Failed to initialize camera: $e');
      _isInitialized = false;
      return false;
    }
  }

  /// Request camera permission
  Future<bool> requestPermission() async {
    try {
      final status = await Permission.camera.request();
      return status.isGranted;
    } catch (e) {
      print('Failed to request camera permission: $e');
      return false;
    }
  }

  /// Check if camera permission is granted
  Future<bool> hasPermission() async {
    try {
      final status = await Permission.camera.status;
      return status.isGranted;
    } catch (e) {
      print('Failed to check camera permission: $e');
      return false;
    }
  }

  /// Check if camera permission is permanently denied
  Future<bool> isPermissionPermanentlyDenied() async {
    try {
      final status = await Permission.camera.status;
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

  /// Capture an image and return the file path
  Future<String?> captureImage() async {
    if (!_isInitialized || _controller == null || !_controller!.value.isInitialized) {
      print('Camera not initialized');
      return null;
    }

    try {
      final image = await _controller!.takePicture();
      return image.path;
    } catch (e) {
      print('Failed to capture image: $e');
      return null;
    }
  }

  /// Enable or disable flash
  Future<void> setFlashMode(FlashMode mode) async {
    if (_controller == null || !_isInitialized) return;

    try {
      await _controller!.setFlashMode(mode);
    } catch (e) {
      print('Failed to set flash mode: $e');
    }
  }

  /// Get current camera controller
  CameraController? get controller => _controller;

  /// Check if camera is initialized
  bool get isInitialized => _isInitialized && _controller != null && _controller!.value.isInitialized;

  /// Get camera preview aspect ratio
  double get aspectRatio => _controller?.value.aspectRatio ?? 1.0;

  /// Dispose camera resources
  Future<void> dispose() async {
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
    }
    _isInitialized = false;
  }
}
