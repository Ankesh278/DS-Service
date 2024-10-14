import 'package:ds_service/Auth/tellUsScreen.dart';
import 'package:flutter/material.dart';

import '../AppsColor/appColor.dart';
import '../Resources/AppImages.dart';

class TermsAcceptanceScreen extends StatelessWidget {
  const TermsAcceptanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          // Top Right Image
          Stack(
            children: [
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: screenWidth*0.05,top: screenHeight*0.1),
                child: Image.asset(appImages.Ellipse), // Update with your image path
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: screenWidth*0.1,top: screenHeight*0.15),
                child: Image.asset(appImages.EditFile), // Update with your image path
              ),
            ],
          ),

          // Main Content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Updates to our terms &\n conditions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Review and accept updated terms &\nconditions to continue working with DS WALE\nCompany',
                    style: TextStyle(fontSize: 10),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // Navigate to full terms and conditions
                    },
                    child: const Row(
                      children: [
                        Text(
                          'View terms & Conditions',
                          style: TextStyle(color: Colors.blue,fontSize: 14),
                        ),
                        ImageIcon(AssetImage(appImages.LeftArrow),color: Colors.blue,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Tellusscreen()),
                            (Route<dynamic> route) => false, // This removes all previous routes
                      );

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding for button height
                      minimumSize: const Size(230, 30), // Adjust the width and height
                      shape: const StadiumBorder(), // Creates the circular shape (pill shape)
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please accept Terms & conditions to proceed...",style: TextStyle(color: Colors.white,fontSize: 12),),backgroundColor: AppColors.primaryColor,));
                      // Handle button press
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor, side: const BorderSide(color: AppColors.primaryColor, width: 2), // Border color and width
                      padding: const EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding for button height
                      minimumSize: const Size(230, 30), // Adjust the width and height
                      shape: const StadiumBorder(), // Creates the circular shape (pill shape)
                    ),
                    child: const Text(
                      'Not now',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
