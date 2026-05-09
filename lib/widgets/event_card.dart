import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final String title;
  final String dateDay;
  final String dateMonth;
  final String imagePath;
  final String price;
  final String timeRange;
  final String location;
  final VoidCallback onRSVP;

  const EventCard({
    super.key,
    required this.title,
    required this.dateDay,
    required this.dateMonth,
    required this.imagePath,
    required this.price,
    required this.timeRange,
    required this.location,
    required this.onRSVP,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isWishlisted = false;

  static const Color _brown = Color(0xFF9E8576);
  static const Color _dark = Color(0xFF1A2130);
  static const Color _darkBrown = Color(0xFF3D2C2C);

  @override
  Widget build(BuildContext context) {
    final isFree = widget.price == 'FREE';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Hero image with overlays
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  widget.imagePath,
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Date badge (top left)
              Positioned(
                top: 12,
                left: 12,
                child: _buildDateBadge(),
              ),
              // Wishlist button (top right)
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => setState(() => _isWishlisted = !_isWishlisted),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isWishlisted ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: _isWishlisted ? Colors.redAccent : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── Title + price row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: _dark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isFree
                      ? const Color(0xFFEBF5EB)
                      : const Color(0xFFFFF3EE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.price,
                  style: TextStyle(
                    color: isFree ? Colors.green.shade700 : const Color(0xFFC68E74),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // ── Time row
          _buildDetailRow(Icons.access_time_outlined, widget.timeRange),
          const SizedBox(height: 6),

          // ── Location row
          _buildDetailRow(Icons.location_on_outlined, widget.location),
          const SizedBox(height: 18),

          // ── CTA button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.onRSVP,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFree ? _darkBrown : _brown,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                elevation: 0,
              ),
              child: Text(
                isFree ? 'Join Waitlist' : 'RSVP Now',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.08), blurRadius: 6)
        ],
      ),
      child: Column(
        children: [
          Text(widget.dateMonth,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          Text(widget.dateDay,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: _dark)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 15, color: Colors.grey.shade400),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}