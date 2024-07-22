import 'package:flutter/material.dart';
import 'package:annapardaan/onboarding/onboarding_screen.dart';
import 'package:annapardaan/screens/auth/login_screen.dart';
import '../utils/constants/colors.dart';

class MyApp extends StatelessWidget {
  final bool showOnboarding;

  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
