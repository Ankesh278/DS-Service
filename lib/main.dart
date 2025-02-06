
import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Auth/SplashScreen.dart';
import 'package:ds_service/provider/CalendarProvider/working_day_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Need to Assist',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}


