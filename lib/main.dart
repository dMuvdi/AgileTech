import 'package:agile_tech/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const GetMaterialApp(home: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFFFF5454),
        primaryColorDark: const Color(0xFF670F0F),
        primaryColorLight: const Color(0xFFFFE1E1),
      ),
      home: const SplashScreen(),
    );
  }
}
