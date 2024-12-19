import 'package:cool_app/view/dashboard.dart';
import 'package:cool_app/view/profile_screen.dart';
import 'package:cool_app/view/settings.dart';
import 'package:flutter/material.dart';

class GroupMessageScreen extends StatelessWidget {
  const GroupMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF80CBB2), // Light green theme
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Groups",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: const [
                GroupTile(
                  name: "Diamond Team",
                  message: "Thanks a bunch! Have a great day! 😊",
                  time: "10:25",
                ),
                GroupTile(
                  name: "AI Enthusiasts",
                  message: "Great, thanks so much! 🤖",
                  time: "22:20",
                ),
                GroupTile(
                  name: "Game Dev Club 🎮",
                  message: "Hooray! 🎉",
                  time: "05:05",
                ),
                GroupTile(
                  name: "IT Training",
                  message: "Appreciate it! See you soon! 🚀",
                  time: "01/05",
                ),
              ],
            ),
          ),
          const BottomNavigationBarWidget(currentIndex: 1),
        ],
      ),
    );
  }
}

class GroupTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;

  const GroupTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.group, color: Colors.white),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(color: Colors.black54),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        time,
        style: const TextStyle(fontSize: 12, color: Colors.black54),
      ),
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
                // Navigate to the ChatScreen
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
                // Navigate to the GroupMessageScreen
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: const BottomNavItem(icon: Icons.person, label: "Profile"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            child: const BottomNavItem(icon: Icons.settings, label: "Settings"),
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
