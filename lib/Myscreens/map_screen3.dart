import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapScreen3 extends StatefulWidget {
  const MapScreen3({super.key});

  @override
  MapScreen3State createState() => MapScreen3State();
}

class MapScreen3State extends State<MapScreen3> {
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
                    Positioned(top: 376.h,left: 46.w,
                        child: SizedBox(
                          width: 300.w,height: 60.h,
                            child: Text('Why are you starting job from\nother location',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20.sp),))
                    ),
                    Positioned(width: 340.w,height: 112.h,top: 696.h,left: 27.w,
                        child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),

                        )),
                    Positioned(width: 264.w,height: 38.h,top: 752.h,left: 63.w,
                        child: Container(decoration: BoxDecoration(color: AppColors.greyColor,borderRadius: BorderRadius.circular(20)),
                          child: Center(child: Text('Mark Arrived'),),)),

                    Positioned(width: 340.w,height: 32.h,top: 696.h,left: 27.w,
                        child: Container(decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.vertical(top:Radius.circular(10),)),child: Center(child: 
                          Text('Answer honestly to avoid penalty',style: TextStyle(color: Colors.white),),),

                        )),
                    Positioned(width: 250.w,height: 25.h,top: 435.h,left: 39.w,
                        child: Row(
                          children: [Icon(Icons.check_circle,color: Colors.white,),
                            SizedBox(width: 10.w,),
                            Text('Customer location incorrect',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15.sp),),
                          ],
                        )
                    ),
                    Positioned(width: 350.w,height: 50.h,top: 475.h,left: 39.w,
                        child: Row(
                          children: [Icon(Icons.check_circle,color: Colors.white,),
                            SizedBox(width: 10.w,),
                            Text('Customer requested service at different\nlocation',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15.sp),),
                          ],
                        )
                    ),
                    Positioned(width: 250.w,height: 25.h,top: 525.h,left: 39.w,
                        child: Row(
                          children: [Icon(Icons.check_circle,color: Colors.white,),
                            SizedBox(width: 10.w,),
                            Text('Other',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15.sp),),
                          ],
                        )
                    )
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
