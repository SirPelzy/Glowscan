import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowscan_app/core/theme/app_theme.dart';
// import 'package:image_picker/image_picker.dart'; // You will need this for functionality

class ImageCaptureScreen extends StatefulWidget {
  const ImageCaptureScreen({super.key});

  @override
  State<ImageCaptureScreen> createState() => _ImageCaptureScreenState();
}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  // TODO: Initialize camera controller here using the 'camera' package

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // This container is a placeholder for your camera preview.
          // In a real app, you would replace this with CameraPreview(controller).
          Positioned.fill(
            child: Container(
              color: Colors.grey[800],
              child: const Center(
                child: Text(
                  'Camera Preview',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          // Top Bar (Close button and Title)
          _buildTopBar(),

          // Bottom Controls (Gallery, Shutter, Flip Camera)
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: SvgPicture.asset('assets/images/x-close.svg', colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Text('Scan', style: AppTheme.heading2.copyWith(color: Colors.white)),
              const SizedBox(width: 48), // To balance the IconButton
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                iconPath: 'assets/images/images.svg',
                onPressed: () {
                  // TODO: Use image_picker to pick from gallery
                },
              ),
              _buildControlButton(
                iconPath: 'assets/images/camera.svg',
                isShutter: true,
                onPressed: () {
                  // TODO: Use camera controller to take picture
                },
              ),
              _buildControlButton(
                iconPath: 'assets/images/spiral.svg',
                onPressed: () {
                  // TODO: Use camera controller to flip camera
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({required String iconPath, required VoidCallback onPressed, bool isShutter = false}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: isShutter ? 72 : 56,
        height: isShutter ? 72 : 56,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: isShutter ? 32 : 24,
            height: isShutter ? 32 : 24,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
