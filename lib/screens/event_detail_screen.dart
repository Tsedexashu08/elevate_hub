import 'package:flutter/material.dart';

class EventDetailScreen extends StatefulWidget {
  final Map<String, dynamic> event;

  const EventDetailScreen({super.key, required this.event});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool _isBookmarked = false;

  static const Color _brown = Color(0xFF9E8576);
  static const Color _beige = Color(0xFFF1EDE8);
  static const Color _lightBeige = Color(0xFFEBE5DE);
  static const Color _dark = Color(0xFF1A2130);
  static const Color _darkBrown = Color(0xFF3D2C2C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _beige,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroImage(),
                _buildContent(),
                const SizedBox(height: 110),
              ],
            ),
          ),
          _buildTopBar(context),
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ─── TOP ACTION BAR ─────────────────────────────────────────────────────────
  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _iconButton(
                Icons.arrow_back,
                onTap: () => Navigator.pop(context),
              ),
              Row(
                children: [
                  _iconButton(Icons.share_outlined),
                  const SizedBox(width: 10),
                  _iconButton(
                    _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: _isBookmarked ? _brown : _dark,
                    onTap: () => setState(() => _isBookmarked = !_isBookmarked),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon,
      {Color color = _dark, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }

  // ─── HERO IMAGE ─────────────────────────────────────────────────────────────
  Widget _buildHeroImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
      child: Image.asset(
        widget.event['image'] ?? 'assets/images/crowd.jpg',
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  // ─── MAIN CONTENT ────────────────────────────────────────────────────────────
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: _lightBeige,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'TECH & INNOVATION',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: _brown,
                letterSpacing: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Title
          Text(
            widget.event['title'] ?? 'Future of Tech: Annual Creative Summit 2024',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: _dark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 22),

          // Date info row
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            primary: 'October 24, 2024',
            secondary: widget.event['time'] ?? '10:00 AM – 06:00 PM',
          ),
          const SizedBox(height: 14),

          // Location info row
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            primary: widget.event['location'] ?? 'Grand Convention Center',
            secondary: 'San Francisco, CA',
          ),
          const SizedBox(height: 26),

          // Map preview
          _buildMapPreview(),
          const SizedBox(height: 26),

          // About Event
          _sectionTitle('About Event'),
          const SizedBox(height: 10),
          const Text(
            'Join us for the most anticipated tech event of the year. The Future of Tech Summit brings together visionaries, developers, and designers to explore the next frontier of human-centric innovation.',
            style: TextStyle(
                fontSize: 14, color: Colors.grey, height: 1.65),
          ),
          const SizedBox(height: 26),

          // Organizer
          _buildOrganizerSection(),
          const SizedBox(height: 26),

          // Speakers
          _buildSpeakersSection(),
          const SizedBox(height: 26),

          // Agenda
          _buildAgendaSection(),
          const SizedBox(height: 26),

          // Sponsors
          _buildSponsorsSection(),
        ],
      ),
    );
  }

  // ─── HELPERS ─────────────────────────────────────────────────────────────────

  Widget _sectionTitle(String title) {
    return Text(title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: _dark));
  }

  Widget _buildInfoRow(
      {required IconData icon,
      required String primary,
      required String secondary}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: _lightBeige,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, size: 20, color: _brown),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                primary,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14, color: _dark),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                secondary,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMapPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: CustomPaint(
          painter: _MapPainter(),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_pin, color: _brown, size: 40),
                SizedBox(height: 4),
                Text(
                  'Grand Convention Center',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _dark),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrganizerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _sectionTitle('Organizer')),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                backgroundColor: _lightBeige,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Follow',
                  style: TextStyle(
                      color: _brown, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const CircleAvatar(
              radius: 26,
              backgroundColor: _lightBeige,
              child: Icon(Icons.business, color: _brown, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Creative Network Int.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15, color: _dark),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '4.5k followers',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpeakersSection() {
    final speakers = [
      {'name': 'Sarah L.', 'image': 'assets/images/hr1.jpg'},
      {'name': 'Mark B.', 'image': null},
      {'name': 'Reece R.', 'image': null},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Speakers'),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: speakers
                .map((s) => Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: _lightBeige,
                            backgroundImage: s['image'] != null
                                ? AssetImage(s['image']!)
                                : null,
                            child: s['image'] == null
                                ? const Icon(Icons.person,
                                    color: _brown, size: 28)
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            s['name']!,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAgendaSection() {
    final agenda = [
      {
        'time': '10:00 AM',
        'title': 'Opening Keynote',
        'desc': 'The Future of AI in Creative Design'
      },
      {
        'time': '11:30 AM',
        'title': 'Workshop Design Patterns',
        'desc': 'Building Reusable Design Systems'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Agenda'),
        const SizedBox(height: 16),
        ...agenda.map((item) => _buildAgendaItem(
            item['time']!, item['title']!, item['desc']!)),
      ],
    );
  }

  Widget _buildAgendaItem(String time, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                    color: _brown, shape: BoxShape.circle),
              ),
              Container(
                width: 2,
                height: 44,
                color: _lightBeige,
              ),
            ],
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time,
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: _dark)),
                const SizedBox(height: 2),
                Text(desc,
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey.shade500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSponsorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Sponsors'),
        const SizedBox(height: 16),
        Row(
          children: List.generate(
            3,
            (i) => Padding(
              padding: const EdgeInsets.only(right: 14),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: _lightBeige,
                child:
                    Icon(Icons.business_center, color: Colors.grey.shade400, size: 26),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ─── BOTTOM PRICE BAR ────────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    final price = widget.event['price'] ?? '\$45.00';
    final isFree = price == 'FREE';

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 24,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Price',
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(
                    price,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _dark),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: _brown, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('RSVP',
                    style: TextStyle(
                        color: _brown, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFree ? _brown : _darkBrown,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                ),
                child: Text(
                  isFree ? 'Join Free' : 'Buy Ticket',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── FAKE MAP PAINTER ─────────────────────────────────────────────────────────
class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFD8E8C0);
    canvas.drawRect(Offset.zero & size, bg);

    // Park blobs
    final park = Paint()..color = const Color(0xFFC4DBA8);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.75, size.height * 0.35),
            width: size.width * 0.45,
            height: size.height * 0.4),
        park);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.15, size.height * 0.7),
            width: size.width * 0.3,
            height: size.height * 0.3),
        park);

    // Roads
    final road = Paint()
      ..color = Colors.white
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
        Offset(0, size.height * 0.38), Offset(size.width, size.height * 0.38), road);
    canvas.drawLine(
        Offset(0, size.height * 0.62), Offset(size.width, size.height * 0.65), road);
    canvas.drawLine(
        Offset(size.width * 0.32, 0), Offset(size.width * 0.35, size.height), road);
    canvas.drawLine(
        Offset(size.width * 0.65, 0), Offset(size.width * 0.62, size.height), road);

    final minor = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
        Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.5), minor);
    canvas.drawLine(
        Offset(size.width * 0.5, 0), Offset(size.width * 0.48, size.height), minor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
