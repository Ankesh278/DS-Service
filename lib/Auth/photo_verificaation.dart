import 'dart:io';
import 'package:ds_service/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ds_service/Resources/app_images.dart';
class PhotoVerification extends StatefulWidget {
  const PhotoVerification({super.key});
  @override
  State<PhotoVerification> createState() => _PhotoVerificationState();
}

class _PhotoVerificationState extends State<PhotoVerification> {
  late CameraController _cameraController;
  late List<CameraDescription> cameras;
  XFile? _capturedImage;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }
  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );
    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.medium,
    );
    await _cameraController.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }
  void disposeCamera() {
    if (_isCameraInitialized) {
      _cameraController.dispose();
      _isCameraInitialized = false;
    }
  }
  @override
  void dispose() {
    disposeCamera();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppImages.rectangleVerify,
              fit: BoxFit.cover,
              height: screenHeight * 0.23,
            ),
          ),
          Positioned(
            top: screenHeight * 0.08,
            left: screenWidth * 0.05,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
              onPressed: () {
                disposeCamera();
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: screenHeight * 0.17,
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                '"Snap a selfie!"',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Main Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.25),
                  width: screenHeight * 0.35,
                  height: screenHeight * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withValues(alpha: 0.6),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: _capturedImage != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(_capturedImage!.path),
                      fit: BoxFit.cover,
                    ),
                  )
                      : (_isCameraInitialized
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CameraPreview(_cameraController),
                  )
                      : const Center(
                    child: Text(
                      'Initializing camera...',
                      style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                    ),
                  )),
                ),
              ),
              const Spacer(),
              // Camera Button
              GestureDetector(
                onTap: () async {
                  if (!_isCameraInitialized) {
                    await initializeCamera();
                  } else if (_cameraController.value.isInitialized) {
                    final image = await _cameraController.takePicture();
                    setState(() {
                      _capturedImage = image;
                    });
                  }
                },
                child: CircleAvatar(
                  radius: screenWidth*0.1,
                  child: Image.asset(AppImages.cameraCircle),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              if (_capturedImage != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _capturedImage = null;
                        });
                      },
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label:  const Text('Retake'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth*0.07),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        disposeCamera();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MainScreen()),
                        );
                      },
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      label: const Text('Done'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth*0.07),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ],
      ),
    );
  }
}
