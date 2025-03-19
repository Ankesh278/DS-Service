import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalCost extends StatefulWidget {
  const TotalCost({super.key});

  @override
  TotalCostState createState() => TotalCostState();
}

class TotalCostState extends State<TotalCost> {
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
                decoration: const BoxDecoration(color: Color(0xff404140)),
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

                    // Status Box
                    Positioned(
                      top: 112.h,
                      left: 37.w,
                      child: Container(
                        width: 320.w,
                        height: 75.h,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('NOT STARTED', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.sp)),
                              Text('Today, 8:00 PM', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Customer Details
                    Positioned(
                      top: 258.h,
                      left: 29.w,
                      child: Text('Test Kunal', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.grey)),
                    ),

                    // Repeat Customer Badge
                    Positioned(
                      top: 260.h,
                      left: 120.w,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green, size: 15),
                            Text('REPEAT CUSTOMER', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8.sp, color: Colors.green)),
                          ],
                        ),
                      ),
                    ),

                    // Address
                    Positioned(
                      top: 287.h,
                      left: 29.w,
                      child: Text(
                        'Dadar, Dadar West, Dadar, Mumbai,\nMaharashtra 400028, India',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.grey),
                      ),
                    ),

                    // Job Details
                    Positioned(
                      top: 372.h,
                      left: 29.w,
                      child: Text('Job details', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black)),
                    ),

                    // Price and Quantity Details
                    Positioned(
                      top: 419.h,
                      left: 29.w,
                      child: Container(width: 196.w, height: 21.h, color: Color(0xffEFEDF0)),
                    ),
                    Positioned(
                      top: 464.h,
                      left: 29.w,
                      child: Container(width: 131.w, height: 21.h, color: Color(0xffEFEDF0)),
                    ),
                    Positioned(
                      top: 491.h,
                      left: 29.w,
                      child: Container(width: 196.w, height: 21.h, color: Color(0xffEFEDF0)),
                    ),
                    Positioned(
                      top: 556.h,
                      left: 29.w,
                      child: Container(width: 131.w, height: 21.h, color: Color(0xffEFEDF0)),
                    ),

                    // Prices
                    Positioned(
                      top: 420.h,
                      left: 324.w,
                      child: Text('₹ 1098', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.grey)),
                    ),
                    Positioned(
                      top: 467.h,
                      left: 324.w,
                      child: Text('₹ 299', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.grey)),
                    ),
                    Positioned(
                      top: 554.h,
                      left: 324.w,
                      child: Text('₹ 99', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.grey)),
                    ),

                    // Quantity
                    Positioned(
                      top: 417.h,
                      left: 259.w,
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.greyColor),
                        child: Center(child: Text('2', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black))),
                      ),
                    ),
                    Positioned(
                      top: 464.h,
                      left: 259.w,
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.greyColor),
                        child: Center(child: Text('1', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black))),
                      ),
                    ),

                    // Total Amount
                    Positioned(
                      top: 627.h,
                      left: 17.w,
                      child: Container(
                        width: 350.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 2, offset: Offset(0, 1))],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Total', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.white)),
                              SizedBox(width: 30.w),
                              Text('₹ 1496', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(width: 291.w,height: 38.h,top: 801.h,left: 51.w,
                        child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                          child: Center(child: Text('Mark Arrived'),),)),
                    Positioned(width: 22.w,height: 22.h,top: 756.h,left: 15.w,
                        child:Icon(Icons.phone_outlined,color: Colors.white,) ),
                    Positioned(width: 22.w,height: 22.h,top: 756.h,left: 301.w,
                        child:Icon(Icons.directions,color: Colors.white,) ),
                    Positioned(width: 22.w,height: 22.h,top: 756.h,left: 340.w,
                        child:Icon(Icons.question_mark_outlined,color: Colors.white,) )
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
