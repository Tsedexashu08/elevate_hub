import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import 'event_detail_screen.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  static const Color _brown = Color(0xFF9E8576);
  static const Color _beige = Color(0xFFF1EDE8);
  static const Color _lightBeige = Color(0xFFEBE5DE);
  static const Color _dark = Color(0xFF1A2130);

  final List<Map<String, dynamic>> featuredEvents = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _beige,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 24),
              _buildSearchBar(),
              const SizedBox(height: 30),
              _buildSectionHeader('Explore Categories', onSeeAll: () {}),
              const SizedBox(height: 16),
              _buildCategories(),
              const SizedBox(height: 30),
              _buildSectionHeader('Recommended for You', onSeeAll: () {}),
              const SizedBox(height: 16),
              _buildFeaturedEvents(),
              const SizedBox(height: 30),
              _buildPromotionCard(),
              const SizedBox(height: 120), // Extra space for nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 26,
          backgroundImage: AssetImage('assets/images/hr1.jpg'),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning,',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Text(
                'Alex Thompson 👋',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: _dark),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Icon(Icons.notifications_none_outlined, color: _dark),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search workshops, events...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
          VerticalDivider(width: 20, indent: 15, endIndent: 15),
          Icon(Icons.tune, color: _brown, size: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: _dark),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text(
            'See All',
            style: TextStyle(color: _brown, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'name': 'Music', 'icon': Icons.music_note_outlined},
      {'name': 'Tech', 'icon': Icons.computer_outlined},
      {'name': 'Art', 'icon': Icons.palette_outlined},
      {'name': 'Networking', 'icon': Icons.hub_outlined},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(cat['icon'] as IconData, color: _brown),
                ),
                const SizedBox(height: 8),
                Text(
                  cat['name'] as String,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500, color: _dark),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeaturedEvents() {
    return SizedBox(
      height: 320, // Adjust height based on EventCard
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featuredEvents.length,
        itemBuilder: (context, index) {
          final event = featuredEvents[index];
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailScreen(event: event),
                ),
              ),
              child: EventCard(
                title: event['title'],
                dateDay: event['day'],
                dateMonth: event['month'],
                imagePath: event['image'],
                price: event['price'],
                timeRange: event['time'],
                location: event['location'],
                onRSVP: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EventDetailScreen(event: event),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromotionCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _dark,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unleash the VIP in You',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Join exclusive summits across Africa with Evently Prime.',
                  style: TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _brown,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 0,
            ),
            child: const Text('Upgrade'),
          ),
        ],
      ),
    );
  }
}
