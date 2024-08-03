// import 'package:flutter/material.dart';
// import 'package:annapardaan/onboarding/onboarding_screen.dart';
// import 'package:annapardaan/screens/auth/login_screen.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import '../utils/constants/colors.dart';

// class MyApp extends StatelessWidget {
//   final bool showOnboarding;

//   const MyApp({super.key, required this.showOnboarding});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       theme: ThemeData(
//         primaryColor: TColors.primaryLight,
//         scaffoldBackgroundColor: Colors.white,
//         progressIndicatorTheme:const ProgressIndicatorThemeData(
//       color: TColors.primaryLight,
//     ),
//       ),
//       home: showOnboarding ? const LoginScreen() : const OnboardingScreen(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../onboarding/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../utils/constants/colors.dart';
import '../providers/local_provider.dart';

class MyApp extends StatelessWidget {
  final bool showOnboarding;

  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      locale: localeProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('zh'),
        Locale('ru'),
        Locale('fr'),
        Locale('pt'),
        Locale('de'),
        Locale('ms'),
        Locale('ar'),
        Locale('pa'),
        Locale('bn'),
        Locale('es'),
      ],
      theme: ThemeData(
        primaryColor: TColors.primaryLight,
        scaffoldBackgroundColor: Colors.white,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: TColors.primaryLight,
        ),
      ),
      home: showOnboarding ? const LoginScreen() : const OnboardingScreen(),
    );
  }
}
