
import 'dart:io';

import 'package:ds_service/Resources/app_images.dart';
import 'package:ds_service/Screens/calender_screen.dart';
import 'package:ds_service/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AccountCentre extends StatefulWidget {
  const AccountCentre({super.key});
  @override
  State<AccountCentre> createState() => _AccountCentreState();
}
class _AccountCentreState extends State<AccountCentre> {

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pick from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Capture from Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                AppImages.rectangleVerify, // Replace with your image asset
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.23,
              ),
            ),
            Positioned(
              top: screenHeight * 0.05,
              left: screenWidth * 0.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              top: screenHeight * 0.1,
              left: screenWidth * 0.1,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text("My profile",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 18),),
                  SizedBox(height: screenHeight*0.06,),
                  Center(
                    child: Container(
                      width: screenWidth * 0.72,
                      height: screenHeight * 0.095,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.30),
                            offset: const Offset(4, 4),
                            blurRadius: 12,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: _showImagePickerOptions,
                            child: Container(
                              padding: EdgeInsets.all(screenHeight * 0.035),
                              margin: EdgeInsets.only(left: screenWidth * 0.02),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                                image: _selectedImage != null
                                    ? DecorationImage(
                                  image: FileImage(_selectedImage!),
                                  fit: BoxFit.cover,
                                )
                                    : DecorationImage(
                                  image: AssetImage(AppImages.profile),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text("Ankesh Yadav",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),),
                          Spacer(),
                          CircleAvatar(backgroundColor: Colors.grey.shade300,
                            radius: 15,
                            child: Icon(Icons.edit,size: 18,),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight*0.04,),
                  Container(
                    width: screenWidth*0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.30),
                          offset: const Offset(4, 4),
                          blurRadius: 12,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
                          child: Row(
                            children: [
                              Icon(Icons.margin_outlined,color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Calendar",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                              ),
                              Spacer(),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarScreen()));
                                  },
                                  child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,)),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          width: double.infinity, // Full-width line
                          height: 1, // Line thickness
                          color: Colors.grey, // Line color
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
                          child: Row(
                            children: [
                              Icon(Icons.manage_accounts,color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Job history",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                              ),
                              Spacer(),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                                  },
                                  child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,)),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          width: double.infinity, // Full-width line
                          height: 1, // Line thickness
                          color: Colors.grey, // Line color
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
                          child: Row(
                            children: [
                              Icon(Icons.ac_unit_sharp,color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("My hub",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          width: double.infinity, // Full-width line
                          height: 1, // Line thickness
                          color: Colors.grey, // Line color
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
                          child: Row(
                            children: [
                              Icon(Icons.eight_k_outlined,color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Credits",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: screenWidth*0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.30),
                          offset: const Offset(4, 4),
                          blurRadius: 12,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
                          child: Row(
                            children: [
                              Icon(Icons.safety_check_outlined,color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Insurance",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          width: double.infinity, // Full-width line
                          height: 1, // Line thickness
                          color: Colors.grey, // Line color
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
                          child: Row(
                            children: [
                              Icon(Icons.elderly_outlined,color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Training",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          width: double.infinity, // Full-width line
                          height: 1, // Line thickness
                          color: Colors.grey, // Line color
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
                          child: Row(
                            children: [
                              Icon(Icons.verified_user_outlined,color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Safetym centre",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          width: double.infinity, // Full-width line
                          height: 1, // Line thickness
                          color: Colors.grey, // Line color
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
                          child: Row(
                            children: [
                              Icon(Icons.help_outline_outlined,color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Help centre",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
                          child: Row(
                            children: [
                              Icon(Icons.girl_rounded,color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Add helps",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),


                ],
              ),
            ),
          ],
        )
    );
  }
}






