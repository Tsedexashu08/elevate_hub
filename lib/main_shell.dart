import 'package:flutter/material.dart';
import 'screens/events_screen.dart';
import 'screens/community_screen.dart';
import 'screens/map_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/nav_bar.dart';

/// The main app shell shown after login.
/// All primary tabs share a single floating nav bar via IndexedStack.
class MainShell extends StatefulWidget {
  final int initialIndex;

  const MainShell({super.key, this.initialIndex = 1});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;

  static const Color _brown = Color(0xFF9E8576);

  // Nav tab indices:
  // 0 = Home  1 = Events  2 = Community  3 = Map  4 = Profile
  static const List<Widget> _pages = [
    HomeBody(),           // 0
    EventsBody(),           // 1
    CommunitiesBody(),      // 2
    MapBody(),              // 3
    ProfileBody(),          // 4
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE8),
      body: Stack(
        children: [
          // ── All pages kept alive; only the active one is shown
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),

          // ── Shared floating nav bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ),

          // ── FAB shown only on the Map tab (index 3)
          if (_currentIndex == 3)
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // Could open create-event flow
                  },
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: _brown,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _brown.withValues(alpha: 0.45),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add,
                        color: Colors.white, size: 28),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
