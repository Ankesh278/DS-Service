import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapScreen2 extends StatefulWidget {
  const MapScreen2({super.key});

  @override
  MapScreen2State createState() => MapScreen2State();
}

class MapScreen2State extends State<MapScreen2> {
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
                    Positioned(width: 264.w,height: 38.h,top: 711.h,left: 65.w,
                        child: Container(decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
                          child: Center(child: Text('Okay',style: TextStyle(color: Colors.white),),),)),
                    Positioned(width: 264.w,height: 38.h,top: 756.h,left: 65.w,
                        child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                          child: Center(child: Text('Start from other location'),),)),
                    Positioned(width: 42.w,height: 42.h,top: 410.h,left: 37.w,
                        child: Container(child: Icon(Icons.error,color: Colors.white,),)),
                    Positioned(width: 270.w,height: 50.h,top: 464.h,left: 44.w,
                        child: Text('You are 1137 km away from\nbooking location',style: TextStyle(color: Colors.white),)
                    ),
                    Positioned(width: 310.w,height: 40.h,top: 525.h,left: 44.w,
                        child: Text('Bookig location: Dadar, Dadar West, Dadar,\nMumbai, Maharashtra 400028, India',style: TextStyle(color: Colors.white,),)
                    )


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
