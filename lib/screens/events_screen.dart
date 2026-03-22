import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import '../widgets/nav_bar.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int _selectedIndex = 0;

  // Test Data representing the events in your UI
  final List<Map<String, dynamic>> testEvents = [
    {
      'title': 'Tech Innovators Summit 2024',
      'day': '24',
      'month': 'OCT',
      'price': '\$145.00',
      'time': '09:00 AM - 05:00 PM',
      'location': 'Grand Plaza Convention Center',
      'image': 'assets/images/growth.png',
    },
    {
      'title': 'The Autumn Garden Gala',
      'day': '28',
      'month': 'OCT',
      'price': 'FREE',
      'time': '06:30 PM - 10:00 PM',
      'location': 'Central Botanical Gardens',
      'image': 'assets/images/Africa.png',
    },
    {
      'title': 'Urban Art Workshop',
      'day': '02',
      'month': 'NOV',
      'price': '\$45.00',
      'time': '02:00 PM - 05:00 PM',
      'location': 'The Creative Loft, Downtown',
      'image': 'assets/images/crowd.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE8), // Theme beige
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildSearchBar(),
                  const SizedBox(height: 15),
                  _buildFilterChips(),
                  const SizedBox(height: 25),
                  _buildTailorCard(),
                  const SizedBox(height: 25),
                  const Text(
                    'Upcoming Events',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2130),
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Generating Event Cards from Test Data
                  ...testEvents.map((event) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: EventCard(
                      title: event['title'],
                      dateDay: event['day'],
                      dateMonth: event['month'],
                      imagePath: event['image'],
                      price: event['price'],
                      timeRange: event['time'],
                      location: event['location'],
                      onRSVP: () {},
                    ),
                  )),
                  const SizedBox(height: 100), // Space for floating nav bar
                ],
              ),
            ),
          ),

          // Floating Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
            ),
          ),
        ],
      ),
    );
  }

  // UI Helper: Top Header with Logo and Profile
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF9E8576),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.calendar_month, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              'Evently',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const CircleAvatar(
          backgroundColor: Color(0xFFE5E5E5),
          child: Icon(Icons.person_outline, color: Colors.grey),
        )
      ],
    );
  }

  // UI Helper: Search bar
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search events, workshops...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  // UI Helper: Filter row
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _filterChip('Filters', isPrimary: true, icon: Icons.tune),
          _filterChip('Location', icon: Icons.keyboard_arrow_down),
          _filterChip('Date', icon: Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _filterChip(String label, {bool isPrimary = false, IconData? icon}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFF9E8576) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 16, color: isPrimary ? Colors.white : Colors.black),
          if (icon != null) const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(color: isPrimary ? Colors.white : Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // UI Helper: Tailor your experience card
  Widget _buildTailorCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEBE5DE),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Text('Tailor your experience', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          const Text(
            'Discover events based on your unique interests.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.tune, size: 16),
            label: const Text('Advanced Filters'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9E8576),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          )
        ],
      ),
    );
  }
}