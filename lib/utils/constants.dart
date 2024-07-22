// lib/utils/constants.dart

import 'package:flutter/material.dart';

// Color Palette
class AppColors {
  static const Color primary = Color(0xFFE53935); // HEX #E53935
  static const Color secondary = Color(0xFF424B5A); // HEX #424B5A
  static const Color accent = Color(0xFF303843); // HEX #303843
  static const Color background = Color(0xFFB5B7BB); // HEX #B5B7BB
}

// Typography
class AppTypography {
  static const String fontFamily = 'Outfit';

  static const TextStyle light = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle regular = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle semiBold = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
  );
}

// Icon Sizes
class AppIconSizes {
  static const double small = 16.0;
  static const double medium = 24.0;
  static const double large = 32.0;
}

// Light Theme
final ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  hintColor: AppColors.accent,
  fontFamily: AppTypography.fontFamily,
  textTheme: const TextTheme(
    bodyLarge: AppTypography.regular,
    bodyMedium: AppTypography.light,
    titleLarge: AppTypography.semiBold,
  ),
  iconTheme: const IconThemeData(
    color: AppColors.primary,
    size: AppIconSizes.medium,
  ),
  appBarTheme: AppBarTheme(
    color: AppColors.primary, toolbarTextStyle: TextTheme(
      titleLarge: AppTypography.semiBold.copyWith(color: Colors.white),
    ).bodyMedium, titleTextStyle: TextTheme(
      titleLarge: AppTypography.semiBold.copyWith(color: Colors.white),
    ).titleLarge,
  ), );