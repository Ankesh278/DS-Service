import 'dart:convert';
import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Auth/SplashScreen.dart';
import 'package:ds_service/Screens/main_screen.dart';
import 'package:ds_service/provider/CalendarProvider/working_day_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Myscreens/proof2.dart';
import 'Myscreens/vendor_status.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? vendorId = prefs.getString('vendor_id');

  Widget initialScreen = SplashScreen(); // Default screen

  if (vendorId != null) {
    String status = await fetchVendorStatus(vendorId);
    if (status == "APPROVED") {
      initialScreen = MainScreen();
    } else {
      initialScreen = VendorStatusScreen();
    }
  }

  runApp(MyApp(initialScreen: initialScreen));
}

Future<String> fetchVendorStatus(String vendorId) async {
  try {
    final response = await http.get(
      Uri.parse('http://15.207.112.43:8080/api/vendor/getvendorbyid/$vendorId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['status'] ?? "PENDING";
    }
  } catch (e) {
    print("Error fetching vendor status: $e");
  }
  return "PENDING"; // Default status if API fails
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;

  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkState()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Need to Assist',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
          ),
          home:Proof2()
          /*initialScreen*/, // Decided based on API response
        ),
      ),
    );
  }
}
