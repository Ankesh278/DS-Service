import 'package:camera/camera.dart';
import 'package:ds_service/AppsColor/appColor.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/material.dart';
class IntroScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const IntroScreen({super.key,required this.cameras});
  @override
  _IntroScreenState createState() => _IntroScreenState();
}
class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              buildIntroPage(AppImages.introFirstImage, "Earn double ","And fulfill your dreams"),
              buildIntroPage(AppImages.introSecondImage, "Govt certified training","Get certified by Skill India"),
              buildIntroPage(AppImages.introThirdIimage, "Free insurance and easy loans","For you and your family"),
            ],
          ),
          // Linear dots indicator on the left
          Positioned(
            bottom: 50,
            left: 10, // Adjust as needed
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 25, // Width of the indicator
                  height: 3, // Height of the indicator
                  decoration: BoxDecoration(
                    color: index == currentPage ? AppColors.primaryColor : Colors.grey,
                    borderRadius: BorderRadius.circular(2), // Optional: gives slight rounding
                  ),
                );
              }),
            ),
          ),
          // Bottom right forward arrow
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_circle_right_outlined, color: AppColors.primaryColor),
              onPressed: () {
                if (currentPage < 2) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // Navigate to home or next screen
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) =>  LoginScreen(cameras:cameras)), // Replace with your next screen
                  // );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // A reusable function for creating each intro page
  Widget buildIntroPage(String imagePath, String heading,String desc) {
    return Column(
      children: [
        // Upper half with image and red background
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))
            ),
             // Red background
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(imagePath, fit: BoxFit.cover,height: 250,)),
          ),
        ),
        // Bottom half with text
        Expanded(
          child: Stack(
            children: [
              Container(
                color: AppColors.primaryColor,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40))
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          heading,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          desc,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ],
    );
  }
}


