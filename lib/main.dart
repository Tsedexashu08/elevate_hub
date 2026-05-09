import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/events_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/map_screen.dart';
import 'screens/community_screen.dart';
import 'main_shell.dart';

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
        '/signup': (context) => const SignUpScreen(),
        '/events': (context) => const EventsPage(),
        '/community': (context) => const CommunitiesPage(),
        '/map': (context) => const MapScreen(),
        '/main': (context) => const MainShell(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/event-detail') {
          final event = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => EventDetailScreen(event: event),
          );
        }
        return null;
      },
    );
  }
}
