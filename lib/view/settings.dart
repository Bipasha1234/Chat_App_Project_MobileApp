import 'package:cool_app/view/dashboard.dart';
import 'package:flutter/material.dart';

import 'group_screen.dart';
import 'profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF80CBB2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Settings Screen Content",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 3),
    );
  }
}

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;

  const BottomNavigationBarWidget({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              if (currentIndex != 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              }
            },
            child: BottomNavItem(
              icon: Icons.chat,
              label: "Chats",
              isActive: currentIndex == 0,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex != 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GroupMessageScreen()),
                );
              }
            },
            child: BottomNavItem(
              icon: Icons.group,
              label: "Groups",
              isActive: currentIndex == 1,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex != 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              }
            },
            child: BottomNavItem(
              icon: Icons.person,
              label: "Profile",
              isActive: currentIndex == 2,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex != 3) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              }
            },
            child: BottomNavItem(
              icon: Icons.settings,
              label: "Settings",
              isActive: currentIndex == 3,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF80CBB2) : Colors.black54),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? const Color(0xFF80CBB2) : Colors.black54,
          ),
        ),
      ],
    );
  }
}
