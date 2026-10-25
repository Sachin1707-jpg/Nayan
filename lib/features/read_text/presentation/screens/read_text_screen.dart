import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:visionmate_ai/core/constants/app_colors.dart';
import 'package:visionmate_ai/core/constants/app_sizes.dart';
import 'package:visionmate_ai/shared/widgets/accessible_button.dart';
import 'package:visionmate_ai/services/haptics/haptics_service.dart';
import '../../controllers/read_text_controller.dart';

/// Read Text screen - Camera capture and OCR text recognition
/// 
/// Allows users to:
/// - Capture images of printed text
/// - Extract text using OCR
/// - Hear text read aloud via TTS
/// 
/// Accessibility features:
/// - Voice announcements for all states
/// - Large touch targets
/// - High contrast visuals
/// - Screen reader support
/// - Haptic feedback
class ReadTextScreen extends StatefulWidget {
  const ReadTextScreen({super.key});

  @override
  State<ReadTextScreen> createState() => _ReadTextScreenState();
}

class _ReadTextScreenState extends State<ReadTextScreen> with WidgetsBindingObserver {
  late ReadTextController _controller;
  final HapticsService _haptics = HapticsService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    _controller = ReadTextController();
    _controller.addListener(_onControllerChanged);
    
    // Error callback
    _controller.onError = (error) {
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
    
    // Initialize
    _initializeController();
  }

  Future<void> _initializeController() async {
    await _controller.initialize();
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Dispose camera when app is paused
    if (state == AppLifecycleState.paused) {
      _controller.cameraService.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_controller.isCameraReady) {
        _controller.cameraService.initialize();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Text'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Go back',
          onPressed: () async {
            await _haptics.light();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Status message
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.paddingScreen),
              color: _getStatusColor().withOpacity(0.1),
              child: Semantics(
                liveRegion: true,
                child: Text(
                  _controller.statusMessage,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: _getStatusColor(),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Main content area
            Expanded(
              child: _buildContent(),
            ),

            // Action buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_controller.hasPermissionIssue) {
      return _buildPermissionDenied();
    }

    if (_controller.hasError) {
      return _buildError();
    }

    if (_controller.hasResult) {
      return _buildResultView();
    }

    if (_controller.isCameraReady || _controller.isCapturing || _controller.isProcessing) {
      return _buildCameraPreview();
    }

    // Initializing
    return _buildLoading();
  }

  Widget _buildCameraPreview() {
    final cameraController = _controller.cameraService.controller;
    
    if (cameraController == null || !cameraController.value.isInitialized) {
      return _buildLoading();
    }

    return Stack(
      children: [
        // Camera preview
        Center(
          child: AspectRatio(
            aspectRatio: cameraController.value.aspectRatio,
            child: CameraPreview(cameraController),
          ),
        ),

        // Overlay with instructions
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(AppSizes.paddingCard),
            color: Colors.black.withOpacity(0.7),
            child: Text(
              'Point camera at printed text',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        // Processing overlay
        if (_controller.isProcessing || _controller.isCapturing)
          Container(
            color: Colors.black.withOpacity(0.7),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildResultView() {
    final result = _controller.lastResult;
    
    if (result == null) {
      return _buildError();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.paddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Stats
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingCard),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    icon: Icons.text_fields,
                    label: 'Words',
                    value: result.wordCount.toString(),
                  ),
                  _buildStatItem(
                    icon: Icons.format_list_numbered,
                    label: 'Characters',
                    value: result.characterCount.toString(),
                  ),
                  _buildStatItem(
                    icon: Icons.view_headline,
                    label: 'Lines',
                    value: result.lineCount.toString(),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spacingL),

          // Extracted text
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingCard),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.article,
                        color: AppColors.primary,
                        size: AppSizes.iconL,
                      ),
                      const SizedBox(width: AppSizes.spacingM),
                      Text(
                        'Extracted Text',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacingM),
                  Semantics(
                    label: 'Extracted text content',
                    child: SelectableText(
                      result.fullText,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.5,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: AppSizes.iconM,
        ),
        const SizedBox(height: AppSizes.spacingS),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
              ),
          semanticsLabel: '$value $label',
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          SizedBox(height: AppSizes.spacingL),
          Text('Initializing...'),
        ],
      ),
    );
  }

  Widget _buildPermissionDenied() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingScreen),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: AppSizes.iconXXL,
              color: Colors.orange,
            ),
            const SizedBox(height: AppSizes.spacingL),
            Text(
              'Camera Permission Required',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spacingM),
            Text(
              'To read text from images, VisionMate AI needs access to your camera.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingScreen),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppSizes.iconXXL,
              color: Colors.red,
            ),
            const SizedBox(height: AppSizes.spacingL),
            Text(
              'Error',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spacingM),
            Text(
              _controller.lastError ?? 'An error occurred',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingScreen),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_controller.hasPermissionIssue) ...[
            AccessibleButton(
              label: 'Grant Camera Permission',
              semanticLabel: 'Grant camera permission',
              semanticHint: 'Double tap to request camera permission',
              icon: Icons.camera_alt,
              onPressed: () async {
                await _haptics.medium();
                await _controller.requestPermission();
              },
              height: AppSizes.buttonHeightLarge,
            ),
            const SizedBox(height: AppSizes.spacingM),
            AccessibleButton(
              label: 'Open Settings',
              semanticLabel: 'Open app settings',
              semanticHint: 'Double tap to enable camera permission in settings',
              icon: Icons.settings,
              onPressed: () async {
                await _haptics.light();
                await _controller.openSettings();
              },
              height: AppSizes.buttonHeight,
            ),
          ] else if (_controller.hasResult) ...[
            // Read again button
            AccessibleButton(
              label: 'Read Again',
              semanticLabel: 'Read extracted text again',
              semanticHint: 'Double tap to hear the text read aloud again',
              icon: _controller.isSpeaking ? Icons.volume_up : Icons.volume_off,
              onPressed: _controller.isSpeaking
                  ? () async {
                      await _haptics.light();
                      await _controller.stopSpeaking();
                    }
                  : () async {
                      await _haptics.medium();
                      await _controller.readTextAloud();
                    },
              height: AppSizes.buttonHeightLarge,
            ),
            const SizedBox(height: AppSizes.spacingM),
            // Capture another button
            AccessibleButton(
              label: 'Capture Another',
              semanticLabel: 'Capture another image',
              semanticHint: 'Double tap to take a new photo',
              icon: Icons.camera_alt,
              onPressed: () async {
                await _controller.captureAnother();
              },
              height: AppSizes.buttonHeight,
            ),
          ] else if (_controller.isCameraReady) ...[
            // Capture button
            AccessibleButton(
              label: 'Capture Image',
              semanticLabel: 'Capture image',
              semanticHint: 'Double tap to take a photo of text',
              icon: Icons.camera,
              onPressed: _controller.isBusy
                  ? null
                  : () async {
                      await _controller.captureAndProcess();
                    },
              height: AppSizes.buttonHeightLarge,
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (_controller.state) {
      case ReadTextState.idle:
      case ReadTextState.initializingCamera:
      case ReadTextState.cameraReady:
        return AppColors.textSecondary;
      case ReadTextState.capturingImage:
      case ReadTextState.processingImage:
      case ReadTextState.speaking:
        return AppColors.primary;
      case ReadTextState.displayingResult:
        return AppColors.primary;
      case ReadTextState.permissionDenied:
        return Colors.orange;
      case ReadTextState.error:
        return Colors.red;
    }
  }
}
