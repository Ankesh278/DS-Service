import 'package:camera/camera.dart';
import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Auth/intro_screen.dart';
import 'package:ds_service/Auth/start_screen.dart';
import 'package:ds_service/main.dart';
import 'package:flutter/material.dart';

import '../Resources/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StartScreen()));
    });
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: screenWidth*0.5,
                  height: screenHeight*0.3,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.2),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        value: _animationController.value,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColorLight),
                        backgroundColor: AppColors.greyColor,
                        minHeight: 8,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
