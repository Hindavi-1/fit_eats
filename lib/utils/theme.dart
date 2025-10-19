import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryGreen = Color(0xFF27AE60);
  static const Color tealAccent = Color(0xFF1ABC9C);
  static const Color background = Color(0xFFF9FAFB);
  static const Color darkText = Color(0xFF1E293B);
  static const Color lightGray = Color(0xFFB0BEC5);
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryGreen,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryGreen,
    primary: AppColors.primaryGreen,
    secondary: AppColors.tealAccent,
    background: AppColors.background,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryGreen,
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkText, fontSize: 16),
    bodyMedium: TextStyle(color: AppColors.darkText, fontSize: 14),
    titleLarge: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: AppColors.lightGray),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: AppColors.primaryGreen, width: 2),
    ),
  ),
);
