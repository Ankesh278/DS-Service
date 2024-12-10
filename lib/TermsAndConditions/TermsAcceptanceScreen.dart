
import 'package:ds_service/AppsColor/appColor.dart';
import 'package:ds_service/Auth/photo_verificaation.dart';
import 'package:flutter/material.dart';
import '../Resources/app_images.dart';

class TermsAcceptanceScreen extends StatelessWidget {
  const TermsAcceptanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body:  Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              child: Image.asset(AppImages.ellipseRight)),
          Positioned(
              top: screenHeight*0.07,
              left: screenWidth*0.02,
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: const Icon(Icons.arrow_back_ios))),
          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight*0.8,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                ),
              )
          ),
          Positioned(
              top: screenHeight*0.25,
              right: 0,
              child: Stack(
                children: [
                  Image.asset(AppImages.ellipse,height: screenHeight*0.15,),
           Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image.asset(AppImages.editFile,height: screenHeight*0.1,),
          )
                ],
              )
          ),
          Positioned(
              top: screenHeight*0.43,
              left: screenWidth*0.07,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Important Update: Review Our\nUpdated Terms & Conditions",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),),
                  const SizedBox(height: 10,),
                  const Text("We have recently made updates to our Terms &\nConditions to enhance clarity and align with current\npractices. Please take a moment to review\nand accept the new terms to continue collaborating\nseamlessly with NEED TO ASSISTS Company",style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w400),),
                  const SizedBox(height: 15,),
                  const Text("Thanks you for your\ncoperation and commitment",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text("View terms & conditions",style: TextStyle(color: Colors.blue,fontSize: 12,fontWeight: FontWeight.w500),),
                          Icon(Icons.arrow_forward_outlined,color: Colors.blue,)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PhotoVerification()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: screenWidth*0.6,
                      margin: EdgeInsets.only(left: screenWidth*0.13,top: screenWidth*0.13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primaryColorlight
                      ),
                      child: Center(child: Text("Accept",style: TextStyle(color: Colors.white.withOpacity(0.7))
                        ,)),
                    ),
                  ),
                 Container(
                   padding: const EdgeInsets.symmetric(vertical: 5),
                   width: screenWidth*0.6,
                   margin: EdgeInsets.symmetric(horizontal: screenWidth*0.13,vertical: 15),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: Colors.white
                   ),
                   child:const Center(child: Text("Not now",style: TextStyle(color: AppColors.primaryColorlight)
                     ,)) ,
                 )
                


                ],
              ))



        ],
      ),
    );
  }
}

