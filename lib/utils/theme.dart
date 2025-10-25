import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryGreen = Color(0xFF27AE60);
  static const Color tealAccent = Color(0xFF1ABC9C);
  static const Color warmOrange = Color(0xFFF39C12);
  static const Color background = Color(0xFFF9FAFB);
  static const Color darkText = Color(0xFF1E293B);
  static const Color lightGray = Color(0xFFB0BEC5);
  static const Color white = Colors.white;
}

class AppGradients {
  static const LinearGradient greenMint = LinearGradient(
    colors: [AppColors.primaryGreen, AppColors.tealAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient orangeGlow = LinearGradient(
    colors: [AppColors.warmOrange, AppColors.tealAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  primaryColor: AppColors.primaryGreen,
  scaffoldBackgroundColor: AppColors.background,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  splashFactory: InkRipple.splashFactory,

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

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.primaryGreen,
    unselectedItemColor: AppColors.lightGray,
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    elevation: 12,
  ),

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.darkText,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryGreen,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: AppColors.darkText,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: AppColors.darkText,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      color: AppColors.lightGray,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 4,
      shadowColor: AppColors.primaryGreen.withOpacity(0.3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: AppColors.lightGray),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: AppColors.primaryGreen, width: 2),
    ),
  ),

  cardTheme: CardThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 6,
    shadowColor: Colors.black12,
    color: Colors.white,
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.tealAccent,
    contentTextStyle: const TextStyle(color: Colors.white),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);
