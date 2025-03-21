
import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Auth/login_screen.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  @override
  StartScreenState createState() => StartScreenState();
}
class StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.startScreenImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
          Positioned(
            top: -screenHeight*0.01,
            right: -screenWidth*0.04,
            child: Image.asset(
              AppImages.ellipseRight,
              height: screenHeight*0.15,
              width: screenWidth*0.3,
            ),
          ),
          Positioned(
            top: screenHeight*0.13,
            left: -screenWidth*0.1,
            child: Image.asset(
              AppImages.ellipseLeft,
              height: screenHeight*0.1,
              width: screenWidth*0.3,
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.1, vertical: screenHeight*0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin:  EdgeInsets.only(top: screenHeight*0.1),
                      child: Image.asset(AppImages.logo))
                ],
              ),
            ),
          ),
          // Bottom rectangle
          Positioned(
            bottom: -10,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight*0.54,
              decoration:  BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(screenWidth*0.1),topRight: Radius.circular(screenWidth*0.1))
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight*0.12),
                  width: screenWidth*0.7,
                  height: screenHeight * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print("Clicked");
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth*0.1),
                      ),
                    ),
                    child: const Text('GET STARTED',style: TextStyle(color: AppColors.primaryColor),),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
