import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';


void main() {
  runApp(const FitEatsApp());
}

class FitEatsApp extends StatelessWidget {
  const FitEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitEats',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
