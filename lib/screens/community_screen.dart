import 'package:flutter/material.dart';

/// Body-only Communities page — no nav bar (provided by MainShell).
class CommunitiesBody extends StatefulWidget {
  const CommunitiesBody({super.key});

  @override
  State<CommunitiesBody> createState() => _CommunitiesBodyState();
}

class _CommunitiesBodyState extends State<CommunitiesBody> {
  int _activeTab = 0; // 0: Groups, 1: Attendees, 2: My Cards

  static const Color _brown = Color(0xFF9E8576);
  static const Color _lightBeige = Color(0xFFEBE5DE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 25),
              _buildToggleTabs(),
              const SizedBox(height: 25),
              _buildProfileCard(),
              const SizedBox(height: 30),
              _buildChatListHeader(),
              const SizedBox(height: 15),
              _buildChatTile(
                icon: Icons.theater_comedy_outlined,
                title: 'Main Stage Discussion',
                lastMessage: 'Sarah: That last speaker was inc...',
                time: '2m ago',
              ),
              _buildChatTile(
                icon: Icons.code,
                title: 'Developers Lounge',
                lastMessage: 'Mike: Anyone looking to pair pro...',
                time: '15m ago',
              ),
              _buildChatTile(
                icon: Icons.rocket_launch_outlined,
                title: 'SaaS Founders',
                lastMessage: 'Elena: Coffee meetup at the lobb...',
                time: '1h ago',
              ),
              // Extra bottom padding for the floating nav bar
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
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
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: _brown, shape: BoxShape.circle),
              child:
                  const Icon(Icons.hub_outlined, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            const Text('Evently',
                style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
            child:
                Icon(Icons.notifications_none, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  // ─── SEARCH BAR ────────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8),
              ],
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search people or groups...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                icon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: _lightBeige,
            borderRadius: BorderRadius.circular(15),
          ),
          child:
              const Icon(Icons.tune, color: Colors.black54, size: 20),
        ),
      ],
    );
  }

  // ─── TOGGLE TABS ───────────────────────────────────────────────────────────
  Widget _buildToggleTabs() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _lightBeige,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _tabItem('Groups', 0),
          _tabItem('Attendees', 1),
          _tabItem('My Cards', 2),
        ],
      ),
    );
  }

  Widget _tabItem(String label, int index) {
    final isActive = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight:
                  isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? _brown : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  // ─── PROFILE CARD ──────────────────────────────────────────────────────────
  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _lightBeige.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/hr1.jpg'),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Alex Thompson',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Product Designer @ Meta',
                    style: TextStyle(
                        color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_2, size: 18),
            label: const Text('MY CARD',
                style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _brown,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }

  // ─── CHAT LIST HEADER ──────────────────────────────────────────────────────
  Widget _buildChatListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Event Group Chats',
            style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(
          onPressed: () {},
          child: const Text('See all',
              style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  // ─── CHAT TILE ─────────────────────────────────────────────────────────────
  Widget _buildChatTile({
    required IconData icon,
    required String title,
    required String lastMessage,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Color(0xFFF1EDE8), shape: BoxShape.circle),
            child: Icon(icon, color: _brown, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(time,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(lastMessage,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── BACKWARD-COMPAT WRAPPER ──────────────────────────────────────────────────
class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) => const CommunitiesBody();
}