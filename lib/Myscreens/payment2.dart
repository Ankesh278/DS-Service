import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Resources/app_images.dart';

class Payment2 extends StatelessWidget {
  const Payment2({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: Container(
        width: double.infinity,
        height: 900.h, // Set a minimum height
        decoration:  const BoxDecoration(color: Colors.white,),
    child: Stack(
    children: [

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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60,),
            const Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,),
            const SizedBox(height: 120,),
            Center(child:
              Image.asset('assets/images/payment_icon.png'),),
            SizedBox(height: 20,),
            Center(child: Text('₹ 3394 Received',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            SizedBox(height: 10,),
            Center(child:
              Text('Via Cash'),)

          ],

        ),
      ),
        ]
      )
      )
    );
  }
}
