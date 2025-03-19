import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class Proof2 extends StatefulWidget {
  const Proof2({super.key});

  @override
  _Proof2State createState() => _Proof2State();
}

class _Proof2State extends State<Proof2> {
  File? _selectedVideo;
  final ImagePicker _picker = ImagePicker();
  bool isUploading = false;

  // 📌 Function to pick a video
  Future<void> pickVideo(ImageSource source) async {
    final pickedFile = await _picker.pickVideo(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedVideo = File(pickedFile.path);
      });
    }
  }

  // 📌 Function to upload the selected video
  Future<void> uploadVideo() async {
    if (_selectedVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a video first')),
      );
      return;
    }

    setState(() {
      isUploading = true;
    });

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://15.207.112.43:8080/api/service/upload-video'),
    );

    request.fields['bookingId'] = "67bf70a8519c0a81c4361554";
    request.fields['vendorId'] = "67c16ffea43ac1d8af69ed6e";

    request.files.add(
      await http.MultipartFile.fromPath(
        'videoProof',
        _selectedVideo!.path,
        contentType: MediaType('video', 'mp4'),
      ),
    );

    try {
      var response = await request.send();
      String responseBody = await response.stream.bytesToString();

      print("Response Code: ${response.statusCode}");
      print("Response Body: $responseBody");

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Video uploaded successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Video upload failed!')),
        );
      }
    } catch (e) {
      print("Error uploading video: $e");
    }

    setState(() {
      isUploading = false;
    });
  }

  // 📌 Function to show video picker options
  void _showVideoPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(children: [
          ListTile(
            leading: Icon(Icons.videocam),
            title: Text('Record Video'),
            onTap: () {
              Navigator.pop(context);
              pickVideo(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.video_library),
            title: Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              pickVideo(ImageSource.gallery);
            },
          ),
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Proof of Work Video',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _showVideoPicker,
                child: Container(
                  width: double.infinity,
                  height: 400,
                  color: Colors.black,
                  child: _selectedVideo == null
                      ? Center(
                    child: Text(
                      'Tap to select a video',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                      : Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isUploading ? null : uploadVideo,
                child: isUploading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Upload Video'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
