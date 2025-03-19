import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../Resources/app_images.dart';

class Proof1 extends StatefulWidget {
  Proof1({super.key});

  @override
  _Proof1State createState() => _Proof1State();
}

class _Proof1State extends State<Proof1> {
  List<String> texts = [
    "Side_by_side_old_and_new_spare",
    "Post Job Laptop Check",
    "Post Job Laptop Check for Physical Condition",
    "Proof of Work"
  ];

  Map<int, File?> selectedImages = {};
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(int index, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        selectedImages[index] = File(pickedFile.path);
      });
      await uploadImage(index);
    }
  }

  Future<void> uploadImage(int index) async {
    if (selectedImages[index] == null) return;
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://15.207.112.43:8080/api/service/repair-proof'));
    request.fields['bookingId'] = "67ce75a339bcad75196bf7c1";
    request.fields['vendorId'] = "67bc12837069384b8663c671";
    request.files.add(
      await http.MultipartFile.fromPath(
        'repairImages',
        selectedImages[index]!.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    var response = await request.send();
    if (response.statusCode == 201) {

      print("Image uploaded successfully");
    } else {
      print("Image upload failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: 900.h,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(children: [
              Positioned(
                left: -75.w,
                top: -50.h,
                child: Image.asset(AppImages.loginEllipse),
              ),
              Positioned(
                top: -30.h,
                right: 0.w,
                child: Image.asset(AppImages.ellipseRight),
              ),
              Positioned(
                left: 10.w,
                top: 30.h,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              Positioned(
                  top: 243.h,
                  left: 18.w,
                  child: Text('Laptop')),
              Positioned(
                top: 275.h,
                left: 14.w,
                right: 14.w,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    spacing: 15.w,
                    runSpacing: 15.h,
                    alignment: WrapAlignment.start,
                    children: List.generate(texts.length, (i) =>
                        GestureDetector(
                          onTap: () => _showImagePicker(i),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xffEFEFEF),
                            ),
                            padding: EdgeInsets.all(10),
                            width: 100.w,
                            height: 100.h,
                            child: selectedImages[i] == null
                                ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload_outlined),
                                Text(
                                  texts[i],
                                  style: TextStyle(fontSize: 8),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            )
                                : Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.file(selectedImages[i]!,
                                      fit: BoxFit.cover),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: Icon(Icons.edit, size: 18),
                                    onPressed: () => _showImagePicker(i),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              Positioned(
                top: 700.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: 345.w,
                    height: 48.h,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (selectedImages.length < texts.length) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please upload all images before continuing')),
                            );
                            return;
                          }

                          // Make the final API request
                          var request = http.MultipartRequest(
                            'POST',
                            Uri.parse('http://15.207.112.43:8080/api/service/repair-proof'),
                          );

                          request.fields['bookingId'] = "67ce75a339bcad75196bf7c1";
                          request.fields['vendorId'] = "67bc12837069384b8663c671";

                          for (var image in selectedImages.values) {
                            if (image != null) {
                              request.files.add(await http.MultipartFile.fromPath(
                                'repairImages',
                                image.path,
                                contentType: MediaType('image', 'jpeg'),
                              ));
                        }
                        }

                        var response = await request.send();
                          String responseBody = await response.stream.bytesToString();
                          print("Response Code: ${response.statusCode}");
                          print("Response Body: $responseBody");
                          if (response.statusCode == 201) {
                        print("All images uploaded successfully");
                        } else {
                        print("Final image upload failed");
                        }


                      },
                      child: Text('Add Proofs Continue',
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minimumSize: Size(screenWidth, 48)),
                    ),
                  ),
                ),
              )
            ])));
  }

  void _showImagePicker(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Take Photo'),
            onTap: () {
              Navigator.pop(context);
              pickImage(index, ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              pickImage(index, ImageSource.gallery);
            },
          ),
        ]);
      },
    );
  }
}