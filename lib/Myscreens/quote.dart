import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Resources/app_images.dart';

class Quote extends StatelessWidget {
  const Quote({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
    body: Container(
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
          top: 112.h,left: 37.w,
          child: (
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey,
                ),
                width: 320.w,height: 75.h,
        padding: EdgeInsets.all(16),
        child: Row(children: [
          Text('Quote',style: TextStyle(color: Colors.white),),
          Spacer(),
          Text('₹ 0',style: TextStyle(color: Colors.white),)
        ],),
    ))
      ),
      Positioned(
          top: 243.h,left: 18.w,
          child:Text('Add Details') ),
      Positioned(
          top: 280.h,left: 18.w,
          child:Text('Laptop pc') ),
      Positioned(
          top: 318.h,left: 18.w,
          child:ElevatedButton(
            onPressed: (){},
            child: Text('Add Details',style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),),) ,
      ),
      Positioned(
        top: 700.h,
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(width: 345.w,height: 48.h,
              child: ElevatedButton(
                onPressed: (){},
                child: Text('Add AC information to continue',style: TextStyle(color: Colors.black),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),minimumSize: Size(screenWidth, 48)),),
            ),
          ) ,
       )
    ]
    // Back Button
    )
    ));
  }
}
