import 'package:elevate_hub/screens/login%20screen.dart';
import 'package:flutter/material.dart';
import 'screens/splash screen.dart';
import 'screens/onboarding screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ElevateHubSplash(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
