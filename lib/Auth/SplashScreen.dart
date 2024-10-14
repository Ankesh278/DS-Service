import 'package:ds_service/AppsColor/appColor.dart';
import 'package:ds_service/Auth/IntroScreen.dart';
import 'package:flutter/material.dart';

import '../Resources/AppImages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for the progress bar
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),  // Duration of the splash screen
    )..forward(); // Start the animation

    // Optionally, navigate to the next screen after the splash screen completes
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const IntroScreen()));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,  // Set the background color for the entire screen
      body: Stack(
        children: [
          // Center the image
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,  // Adjust to minimize extra vertical space
              children: [
                Image.asset(
                  appImages.splash,
                  width: 150,  // Adjust the size of the image as needed
                  height: 150,
                ),
                // Progress bar immediately below the image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        value: _animationController.value,  // Progress based on animation value (0 to 1)
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),  // The color of the progressing part
                        backgroundColor: AppColors.greyColor,  // Background color of the progress bar
                        minHeight: 8,  // Adjust the height of the progress bar
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
