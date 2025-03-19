import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Resources/app_images.dart';

class Proof3 extends StatelessWidget {
  Proof3({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: 900.h, // Set a minimum height
            decoration:  const BoxDecoration(color: Colors.white,),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40.h,),
                        const Row(
                          children: [
                            Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text("Post Job Proof",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                        const SizedBox(height: 200,),
                        Container(
                          width: double.infinity,height:114 ,
                          decoration: BoxDecoration(
                            color: const Color(0xff666766),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child:Stack(
                            children: [
                              Positioned(left: 0,top: 14,
                                  child: Container(width: 7,height: 80,decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
                                  ),
                                  )),
                              Positioned(
                                top: 20,left: 40,
                                child: Container(
                                  width: 64,height: 64,decoration:
                                  BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Image.asset('assets/images/introThirdImage.png'),
                                ),
                              ),
                              const Positioned(
                                top: 10,left: 130,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('STEP 1',style: TextStyle(color: Colors.white,fontSize: 16)),
                                    Text('Show that laptop Speaker, Camera \nand Mic are working',maxLines: 2,style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 5,),
                                    Text('Please make sure that recording is \ndone properly',maxLines: 2,style: TextStyle(color: Colors.white,fontSize: 10),)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,height:114 ,
                          decoration: BoxDecoration(
                            color: const Color(0xff666766),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child:Stack(
                            children: [
                              Positioned(left: 0,top: 14,
                                  child: Container(width: 7,height: 80,decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
                                  ),
                                  )),
                              Positioned(
                                top: 20,left: 40,
                                child: Container(
                                  width: 64,height: 64,decoration:
                                BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                  child: Image.asset('assets/images/introThirdImage.png'),
                                ),
                              ),
                              const Positioned(
                                top: 10,left: 130,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('STEP 2',style: TextStyle(color: Colors.white,fontSize: 16)),
                                    Text('In case of any part is not working,\nhighlight while recording',maxLines: 2,style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 5,),
                                    Text('Play the pre-recorded testing video\nwith audio on.',maxLines: 2,style: TextStyle(color: Colors.white,fontSize: 10),)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                      Center(
                        child: Container(width: 264,height: 36,
                          margin: EdgeInsets.only(bottom: 40,),
                          decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
                          child: Center(child: Text('Ok Got It',style: TextStyle(color: Colors.white),),),),
                      ),

                      ],
                    ),
                  ),


                ]
            )
        ));
  }
}
