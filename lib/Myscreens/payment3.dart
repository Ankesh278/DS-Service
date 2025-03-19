import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Resources/app_images.dart';

class Payment3 extends StatelessWidget {
   Payment3({super.key});
  List<String> texts=["I can’t repair",
    "Customer refused-High Price",
    "Nothing wrong with appliance",
    "Appliance under warranty",
    "Appliance is too old",
    "Spare parts unavailable",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Positioned(width: 394.w,height: 713.h,top: 300.h,left: -1.w,
                      child: Container(
                        decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(50),),color: Color(0xff404140)),

                      )),
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60,),
                        Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,),
                        SizedBox(height: 320,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cannot Repair Laptop PC',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                              SizedBox(height: 10,),
                              Text('Select Reason',style: TextStyle(color: Colors.white),),
                              SizedBox(height: 10,),
                              for(int i=0;i<texts.length;i++)
                                Row(
                                  children: [
                                    Icon(Icons.circle,color: Colors.white,size: 18,),
                                     SizedBox(width: 15,),
                                     Text(texts[i],style: TextStyle(color: Colors.white)
                                     )
                            ],
                          ),
          ]
        )
    ),
                        Spacer(),
                        Center(
                          child: Container(width: 264,height: 36,
                            margin: EdgeInsets.only(bottom: 40,),
                            decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
                            child: Center(child: Text('Continue',style: TextStyle(color: Colors.white),),),),
                        ),

                      ],


                    ),
                  ),
                ]
            )
        )
    );
  }
}
