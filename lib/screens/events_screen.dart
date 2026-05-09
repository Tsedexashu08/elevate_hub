import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import 'event_detail_screen.dart';

/// Body-only Events page — no nav bar (provided by MainShell).
class EventsBody extends StatefulWidget {
  const EventsBody({super.key});

  @override
  State<EventsBody> createState() => _EventsBodyState();
}

class _EventsBodyState extends State<EventsBody> {
  static const Color _brown = Color(0xFF9E8576);
  static const Color _beige = Color(0xFFF1EDE8);
  static const Color _lightBeige = Color(0xFFEBE5DE);
  static const Color _dark = Color(0xFF1A2130);

  final List<Map<String, dynamic>> events = [
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
      backgroundColor: _beige,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 14),
              _buildFilterChips(),
              const SizedBox(height: 24),
              _buildTailorCard(),
              const SizedBox(height: 26),
              const Text(
                'Upcoming Events',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _dark,
                ),
              ),
              const SizedBox(height: 16),
              ...events.map((event) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () => _openDetail(context, event),
                      child: EventCard(
                        title: event['title'],
                        dateDay: event['day'],
                        dateMonth: event['month'],
                        imagePath: event['image'],
                        price: event['price'],
                        timeRange: event['time'],
                        location: event['location'],
                        onRSVP: () => _openDetail(context, event),
                      ),
                    ),
                  )),
              // Extra bottom padding for the floating nav bar
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, Map<String, dynamic> event) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EventDetailScreen(event: event)),
    );
  }

  // ─── HEADER ────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: const BoxDecoration(
                  color: _brown, shape: BoxShape.circle),
              child: const Icon(Icons.calendar_month,
                  color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Text('Evently',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _dark)),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8),
            ],
          ),
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(Icons.person_outline, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  // ─── SEARCH BAR ────────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search events, workshops, concerts...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── FILTER CHIPS ──────────────────────────────────────────────────────────
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _filterChip('  Filters', isPrimary: true, icon: Icons.tune),
          _filterChip('Location', icon: Icons.keyboard_arrow_down),
          _filterChip('Date', icon: Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _filterChip(String label,
      {bool isPrimary = false, IconData? icon}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: isPrimary ? _brown : Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: isPrimary
            ? []
            : [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6),
              ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(icon,
                size: 15,
                color: isPrimary ? Colors.white : Colors.black54),
          if (icon != null) const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: isPrimary ? Colors.white : _dark,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // ─── TAILOR CARD ───────────────────────────────────────────────────────────
  Widget _buildTailorCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: _lightBeige,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const Text('Tailor your experience',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: _dark)),
          const SizedBox(height: 6),
          Text(
            'Discover events based on your unique interests and availability.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.tune, size: 16),
            label: const Text('Advanced Filters',
                style: TextStyle(fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _brown,
              foregroundColor: Colors.white,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── BACKWARD-COMPAT WRAPPER ──────────────────────────────────────────────────
/// Navigating directly to /events still works via this wrapper.
class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) => const EventsBody();
}