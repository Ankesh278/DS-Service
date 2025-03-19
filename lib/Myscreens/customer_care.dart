import 'package:flutter/material.dart';

import '../Resources/app_images.dart';

class CustomerCare extends StatelessWidget {
  const CustomerCare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppImages.rectangleVerify,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
