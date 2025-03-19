import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Background container
              Container(
                width: double.infinity,
                height: 900.h, // Set a minimum height
                decoration:  BoxDecoration(color: Colors.white,),
                child: Stack(
                  children: [
                    // White Background
                    Container(
                      width: screenWidth,
                      height: 750.h,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                        color: Colors.white,
                      ),
                    ),

                    // Decorative Images
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

                    // Back Button
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
                    Positioned(width: 394.w,height: 713.h,top: 300.h,left: -1.w,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(50),),color: Color(0xff404140)),

                    )),
                    Positioned(width: 223.w,height: 284.h,top: 400.h,left: 60.w,child:Image.asset('assets/images/map.png') ,),
                    Positioned(width: 340.w,height: 86.h,top: 726.h,left: 27.w,
                        child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                          child: Center(child: Text('Checking your current\n              location',style: TextStyle(fontWeight: FontWeight.bold),),),)),

                    // Status Box

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
