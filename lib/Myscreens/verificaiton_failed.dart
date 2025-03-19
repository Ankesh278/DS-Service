import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationFailed extends StatefulWidget {
  const VerificationFailed({super.key});

  @override
  VerificationFailedState createState() => VerificationFailedState();
}

class VerificationFailedState extends State<VerificationFailed> {
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
                          child: Center(child: Text('Continue',style: TextStyle(color: Colors.white),),),)),

                    Positioned(width: 42.w,height: 42.h,top: 410.h,left: 37.w,
                        child: Container(child: Icon(Icons.error,color: Colors.white,),)),
                    Positioned(width: 150.w,height: 200.h,top: 477.h,left: 44.w,
                        child: Text('VERIFICATION FAILED',style: TextStyle(color: Colors.white),)
                    ),
                    Positioned(width: 310.w,height: 45.h,top: 525.h,left: 44.w,
                        child: Text('You’ve failed the check multiple\ntimes.',style: TextStyle(color: Colors.white,),)
                    ),
                    Positioned(width: 340.w,height: 25.h,top: 575.h,left: 44.w,
                        child: Text('Our team will call you to understand the issue',style: TextStyle(color: Colors.grey,),)
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
