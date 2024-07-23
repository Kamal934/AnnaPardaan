import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'providers/user_provider.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final showOnboarding = prefs.getBool('onboardingComplete') ?? false;
  runApp(
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
      child: ToastificationWrapper( // Wrap with ToastificationWrapper
        child: MyApp(showOnboarding: showOnboarding),
      ),
    ),
  );
}
