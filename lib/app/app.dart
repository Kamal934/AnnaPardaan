import 'package:flutter/material.dart';
import 'package:annapardaan/onboarding/onboarding_screen.dart';
import 'package:annapardaan/screens/auth/login_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import '../utils/constants/colors.dart';

class MyApp extends StatelessWidget {
  final bool showOnboarding;

  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: TColors.primaryLight,
        scaffoldBackgroundColor: Colors.white,
        progressIndicatorTheme:const ProgressIndicatorThemeData(
      color: TColors.primaryLight,
    ),
      ),
      home: showOnboarding ? const LoginScreen() : const OnboardingScreen(),
    );
  }
}
