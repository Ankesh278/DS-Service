import 'package:camera/camera.dart';
import 'package:ds_service/AppsColor/appColor.dart';
import 'package:ds_service/Auth/SplashScreen.dart';
import 'package:ds_service/provider/CalendarProvider/workingDayProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  // Lock the app in portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Set the status bar color to red
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryColor, // Status bar color
    statusBarIconBrightness: Brightness.light, // Set icon color to light for contrast
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (_) => WorkState()),
      ],
      child: MyApp(),),);
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
      home:  SplashScreen(),
    );
  }
}


