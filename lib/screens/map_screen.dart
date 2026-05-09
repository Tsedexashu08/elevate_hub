import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

/// Body-only Map page — no nav bar (provided by MainShell).
class MapBody extends StatelessWidget {
  const MapBody({super.key});

  static const Color _brown = Color(0xFF9E8576);
  static const Color _lightBeige = Color(0xFFEBE5DE);
  static const Color _dark = Color(0xFF1A2130);

  static const Map<String, dynamic> _featuredEvent = {
    'title': 'Sunset Jazz Night',
    'distance': '1.2 km away',
    'image': 'assets/images/crowd.jpg',
    'day': '24',
    'month': 'OCT',
    'price': 'FREE',
    'time': '07:00 PM - 10:00 PM',
    'location': 'Barton Creek Amphitheater',
  };

  static const List<Map<String, dynamic>> _pins = [
    {'x': 0.52, 'y': 0.42, 'icon': Icons.music_note, 'color': Color(0xFF9E8576)},
    {'x': 0.26, 'y': 0.28, 'icon': Icons.restaurant, 'color': Color(0xFF7A9E76)},
    {'x': 0.72, 'y': 0.55, 'icon': Icons.music_note, 'color': Color(0xFF9E8576)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8E8C0),
      body: Stack(
        children: [
          // Full-screen painted map
          _buildPaintedMap(),
          // Search bar
          _buildTopSearchBar(),
          // NORTH label
          _buildNorthLabel(),
          // Zoom + location controls
          _buildMapControls(),
          // Bottom event preview card
          _buildBottomEventCard(context),
        ],
      ),
    );
  }

  // ─── PAINTED MAP ───────────────────────────────────────────────────────────
  Widget _buildPaintedMap() {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) => CustomPaint(
          painter: MapBackgroundPainter(),
          child: Stack(
            children: _pins.map((pin) {
              return Positioned(
                left: constraints.maxWidth * (pin['x'] as double) - 20,
                top: constraints.maxHeight * (pin['y'] as double) - 20,
                child: _buildPin(pin['icon'] as IconData, pin['color'] as Color),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildPin(IconData icon, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        Container(
          width: 3,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
        ),
      ],
    );
  }

  // ─── TOP SEARCH BAR ────────────────────────────────────────────────────────
  Widget _buildTopSearchBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search locations or events',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: const Icon(Icons.tune, size: 20, color: _dark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── NORTH LABEL ───────────────────────────────────────────────────────────
  Widget _buildNorthLabel() {
    return Positioned(
      top: 90,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'NORTH',
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: _dark,
              letterSpacing: 1),
        ),
      ),
    );
  }

  // ─── MAP CONTROLS ──────────────────────────────────────────────────────────
  Widget _buildMapControls() {
    return Positioned(
      right: 16,
      // Position so controls sit above the bottom event card
      bottom: 220,
      child: Column(
        children: [
          // Location button
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.my_location, size: 22, color: _dark),
            ),
          ),
          // Zoom in
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8),
              ],
            ),
            child: const Padding(

              padding: EdgeInsets.all(12),
            
              child: Icon(Icons.add, size: 22, color: _dark),
            ),
          ),
          Container(height: 1, width: 46, color: const Color(0xFFEEEEEE)),
          // Zoom out
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.remove, size: 22, color: _dark),
            ),
          ),
        ],
      ),
    );
  }

  // ─── BOTTOM EVENT CARD ─────────────────────────────────────────────────────
  Widget _buildBottomEventCard(BuildContext context) {
    return Positioned(
      // Sit above the nav bar and FAB
      bottom: 120,
      left: 16,
      right: 16,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailScreen(event: Map<String, dynamic>.from(_featuredEvent)),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  _featuredEvent['image'] as String,
                  width: 66,
                  height: 66,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _featuredEvent['title'] as String,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: _dark),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 13, color: Colors.grey),
                        const SizedBox(width: 3),
                        Text(
                          _featuredEvent['distance'] as String,
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 34,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EventDetailScreen(
                              event: Map<String, dynamic>.from(_featuredEvent),
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _lightBeige,
                          foregroundColor: _dark,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 18),
                        ),
                        child: const Text('View Event',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── MAP BACKGROUND PAINTER ───────────────────────────────────────────────────
class MapBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final W = size.width;
    final H = size.height;

    canvas.drawRect(
        Offset.zero & size, Paint()..color = const Color(0xFFD4E8BE));

    // Park areas
    final park = Paint()..color = const Color(0xFFC0DBA8);
    canvas.drawOval(
        Rect.fromCenter(center: Offset(W*0.72, H*0.22),
            width: W*0.52, height: H*0.22),
        park);
    canvas.drawOval(
        Rect.fromCenter(center: Offset(W*0.18, H*0.64),
            width: W*0.38, height: H*0.22),
        park);
    canvas.drawOval(
        Rect.fromCenter(center: Offset(W*0.55, H*0.78),
            width: W*0.32, height: H*0.14),
        park);

    // Water
    canvas.drawOval(
        Rect.fromCenter(center: Offset(W*0.47, H*0.44),
            width: W*0.22, height: H*0.10),
        Paint()..color = const Color(0xFFB0CCEA));

    // Block fills
    final block = Paint()
      ..color = const Color(0xFFECE2CC).withValues(alpha: 0.5);
    canvas.drawRect(
        Rect.fromLTWH(W*0.04, H*0.37, W*0.26, H*0.14), block);
    canvas.drawRect(
        Rect.fromLTWH(W*0.38, H*0.60, W*0.22, H*0.12), block);
    canvas.drawRect(
        Rect.fromLTWH(W*0.68, H*0.38, W*0.28, H*0.16), block);

    // Major roads
    final major = Paint()
      ..color = Colors.white
      ..strokeWidth = 11
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, H*0.34), Offset(W, H*0.34), major);
    canvas.drawLine(Offset(0, H*0.56), Offset(W, H*0.60), major);
    canvas.drawLine(Offset(0, H*0.76), Offset(W, H*0.79), major);
    canvas.drawLine(Offset(W*0.34, 0), Offset(W*0.36, H), major);
    canvas.drawLine(Offset(W*0.64, 0), Offset(W*0.61, H), major);

    // Minor roads
    final minor = Paint()
      ..color = Colors.white.withValues(alpha: 0.75)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, H*0.46), Offset(W, H*0.46), minor);
    canvas.drawLine(Offset(0, H*0.68), Offset(W, H*0.68), minor);
    canvas.drawLine(Offset(W*0.20, 0), Offset(W*0.22, H), minor);
    canvas.drawLine(Offset(W*0.50, 0), Offset(W*0.48, H), minor);
    canvas.drawLine(Offset(W*0.80, 0), Offset(W*0.78, H), minor);

    // Labels
    _drawLabel(canvas, 'West\nLake Hills', Offset(W*0.38, H*0.38), 9);
    _drawLabel(canvas, 'Rollingwood', Offset(W*0.42, H*0.52), 8);
    _drawLabel(canvas, 'Barton Hills', Offset(W*0.62, H*0.66), 8);
    _drawLabel(canvas, 'South Lamar', Offset(W*0.55, H*0.84), 8);
    _drawLabel(canvas, 'Broken Spoke', Offset(W*0.44, H*0.73), 8);
    _drawLabel(canvas, 'Tarrytown', Offset(W*0.72, H*0.30), 8);
    _drawLabel(canvas, 'Mayfield Park', Offset(W*0.73, H*0.18), 8);
    _drawLabel(canvas, 'South Austin', Offset(W*0.28, H*0.84), 8);
  }

  void _drawLabel(Canvas canvas, String text, Offset pos, double fontSize) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: const Color(0xFF7A7A6A),
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          height: 1.3,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── BACKWARD-COMPAT WRAPPER ──────────────────────────────────────────────────
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) => const MapBody();
}
