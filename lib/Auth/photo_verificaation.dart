import 'dart:convert';
import 'dart:io';
import 'package:ds_service/Screens/account_centre.dart';
import 'package:ds_service/Screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Myscreens/hub_choose.dart';
import '../Myscreens/vendor_status.dart';
import '../Resources/app_images.dart';


class SelfieScreen extends StatefulWidget {

  SelfieScreen();

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  final HubController hubController = Get.put(HubController());
  late CameraController _cameraController;
  late List<CameraDescription> cameras;
  XFile? _capturedImage;
  bool _isCameraInitialized = false;
  bool isLoading = false;

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
  }Future<void> sendUserDataWithSelfie() async {
    if (_capturedImage == null) {
      Get.snackbar("Error", "Please take a selfie first");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      String? phoneNumber = user.phoneNumber;
      String uid = user.uid;

      // Step 1: Upload Selfie Image
      var imageUploadRequest = http.MultipartRequest(
        'POST',
        Uri.parse("http://15.207.112.43:8080/api/vendor/uploadselfie"),
      );

      String filePath = _capturedImage!.path;
      String? mimeType = lookupMimeType(filePath) ?? 'image/jpeg';

      imageUploadRequest.files.add(
        await http.MultipartFile.fromPath(
          'image',
          filePath,
          contentType: MediaType.parse(mimeType),
          filename: basename(filePath),
        ),
      );

      var imageResponse = await imageUploadRequest.send();
      var imageResponseBody = await imageResponse.stream.bytesToString();

      if (imageResponse.statusCode != 200) {
        Get.snackbar("Error", "Failed to upload selfie");
        return;
      }

      var imageJson = jsonDecode(imageResponseBody);
      String selfieUrl = imageJson['selfieUrl']; // Extract uploaded image URL

      // Step 2: Send Other Data in Raw JSON
      var response = await http.post(
        Uri.parse("http://15.207.112.43:8080/api/vendor/vendordetails"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "fullname": hubController.nameController.text.toString(),
          "profession": hubController.selectedProfession.toString(),
          "hometown": hubController.selectedCity.toString(),
          "phonenumber": phoneNumber ?? "",
          "hubId": hubController.selectedHubId.value,
          "uid": "dzgfdk",
          "selfieUrl": selfieUrl,
          "location": {
            "type": "Point",
            "coordinates": [
              hubController.currentPosition.value.longitude,
              hubController.currentPosition.value.latitude
            ]
          }
        }),
      );

      var responseBody = jsonDecode(response.body);
      print("Response: ${response.statusCode}, Body: $responseBody");

      if (response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('vendor_id', responseBody['vendor']['_id'].toString());

        Get.offAll(VendorStatusScreen());
      } else {
        Get.snackbar("Error", "Failed to submit details");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                Get.back();
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.25),
                  width: screenHeight * 0.35,
                  height: screenHeight * 0.5,
                  child: _capturedImage != null
                      ? Image.file(File(_capturedImage!.path), fit: BoxFit.cover)
                      : (_isCameraInitialized ? CameraPreview(_cameraController) : Text('Initializing camera...')),
                ),
              ),
              const Spacer(),
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
                  radius: screenWidth * 0.1,
                  child: Image.asset(AppImages.cameraCircle),
                ),
              ),
              if (_capturedImage != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () => setState(() => _capturedImage = null), child: Text('Retake')),
                    ElevatedButton(onPressed: sendUserDataWithSelfie, child: isLoading ? CircularProgressIndicator() : Text('Done')),
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
