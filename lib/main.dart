// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';
// import 'app/app.dart';
// import 'providers/user_provider.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   final prefs = await SharedPreferences.getInstance();
//   final showOnboarding = prefs.getBool('onboardingComplete') ?? false;

//   runApp(
//     ChangeNotifierProvider<UserProvider>(
//       create: (_) => UserProvider(),
//       child: MyApp(showOnboarding: showOnboarding),
//     ),
//   );
// }



import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'providers/user_provider.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final showOnboarding = prefs.getBool('onboardingComplete') ?? false;
  // await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
      child: MyApp(showOnboarding: showOnboarding),
    ),
  );
}
