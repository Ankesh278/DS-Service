import 'package:ds_service/AppsColor/appColor.dart';
import 'package:ds_service/Auth/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() {
  // Set the status bar color to red
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryColor, // Status bar color
    statusBarIconBrightness: Brightness.light, // Set icon color to light for contrast
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      home:  const SplashScreen(),
    );
  }
}


