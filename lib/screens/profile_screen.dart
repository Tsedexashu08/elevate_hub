import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  static const Color _brown = Color(0xFF9E8576);
  static const Color _beige = Color(0xFFF1EDE8);
  static const Color _lightBeige = Color(0xFFEBE5DE);
  static const Color _dark = Color(0xFF1A2130);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _beige,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildProfileHeader(),
              const SizedBox(height: 30),
              _buildStats(),
              const SizedBox(height: 40),
              _buildSettingsList(context),
              const SizedBox(height: 120), // Extra space for nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/hr1.jpg'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: _brown,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 20),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Alex Thompson',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: _dark),
        ),
        const SizedBox(height: 4),
        Text(
          'Product Designer @ Meta',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: _brown.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Pro Member',
            style: TextStyle(
                color: _brown, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem('12', 'Attended'),
        _statItem('4k', 'Followers'),
        _statItem('350', 'Following'),
      ],
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: _dark),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          _settingsTile(Icons.person_outline, 'Edit Profile', () {}),
          _settingsTile(Icons.confirmation_num_outlined, 'My Tickets', () {}),
          _settingsTile(Icons.favorite_border, 'Wishlist', () {}),
          _settingsTile(Icons.payment_outlined, 'Payment Methods', () {}),
          _settingsTile(Icons.settings_outlined, 'Settings', () {}),
          const Divider(indent: 20, endIndent: 20),
          _settingsTile(Icons.logout, 'Log Out', () {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          }, isLast: true),
        ],
      ),
    );
  }

  Widget _settingsTile(IconData icon, String title, VoidCallback onTap,
      {bool isLast = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _beige,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: _brown, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: _dark),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }
}
