import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/utils/constants/colors.dart';
import '../utils/constants/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      backgroundColor: TColors.primaryLight,
      splashScreenBody: Center(
        child: Image.asset(
          TImages.appLogo,
          width: 300, 
          height: 250, 
        ),
      ),
      duration: const Duration(seconds: 3), 
    );
  }
}
