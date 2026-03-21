import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  // 1. Define your "Props" (Fields)
  final String title;
  final String dateDay;
  final String dateMonth;
  final String imagePath;
  final String price;
  final String timeRange;
  final String location;
  final VoidCallback onRSVP; // Function prop like 'onClick' in React

  // 2. Add them to the Constructor
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
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  imagePath, // Prop used here
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: _buildDateBadge(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title, // Prop used here
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                price, // Prop used here
                style: const TextStyle(
                  color: Color(0xFFC68E74),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.access_time, timeRange), // Prop used here
          const SizedBox(height: 8),
          _buildDetailRow(Icons.location_on_outlined, location), // Prop used here
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onRSVP, // Callback prop used here
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9E8576),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                elevation: 0,
              ),
              child: const Text('RSVP Now', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for the date badge using props
  Widget _buildDateBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(dateMonth, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
          Text(dateDay, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade400),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
      ],
    );
  }
}