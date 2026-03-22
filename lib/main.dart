import 'package:elevate_hub/screens/login_screen.dart';
import 'package:elevate_hub/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/events_screen.dart';
import 'screens/community_screen.dart';

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
        '/events': (context) => const EventsPage(),
        '/signup': (context) => const SignUpScreen(),
        '/community': (context) => const CommunitiesPage(),
      },
    );
  }
}
