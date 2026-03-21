import 'package:flutter/material.dart';
import 'onboarding screen.dart';

class ElevateHubSplash extends StatefulWidget {
  const ElevateHubSplash({super.key});

  @override
  State<ElevateHubSplash> createState() => _ElevateHubSplashState();
}

class _ElevateHubSplashState extends State<ElevateHubSplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Setup the 3-second timer for the loading bar
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {}); // This tells Flutter to repaint the screen as the bar fills
      });

    _controller.forward();

    // 2. Navigate when the bar hits 100%
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim, secAnim) => const OnboardingScreen(),
            transitionsBuilder: (context, anim, secAnim, child) => 
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFE8DCD0), // The beige background
        child: Stack(
          alignment: Alignment.center,
          children: [
            // --- Background Decorative Circles ---
            Positioned(
              top: -50,
              right: -50,
              child: _buildCircle(250, Colors.white.withOpacity(0.3)),
            ),
            Positioned(
              bottom: 50,
              left: -80,
              child: _buildCircle(350, Colors.white.withOpacity(0.2)),
            ),

            // --- Main Logo & Text ---
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC68E74),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(Icons.layers, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Elevate Hub',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A3428),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Empowering Africa’s\nEvents Ecosystem',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFC68E74),
                    height: 1.4,
                  ),
                ),
              ],
            ),

            // --- Animated Loading Bar & Footer ---
            Positioned(
              bottom: 60,
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        // This width grows from 0 to 120 based on animation
                        width: 120 * _progressAnimation.value,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC68E74),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'CURATING EXCELLENCE',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 2.0,
                      color: Colors.black38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}