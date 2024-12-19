import 'package:cool_app/view/group_screen.dart';
import 'package:cool_app/view/profile_screen.dart';
import 'package:cool_app/view/settings.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF80CBB2), // Light green theme
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Arrow back icon
          onPressed: () {
            Navigator.pop(context); // Navigate back when pressed
          },
        ),
        title: const Text(
          "Chats",
          style: TextStyle(color: Colors.white),
        ), // Title changed to "Chats"
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
                ChatTile(
                  name: "Ram Krishna Lamsal",
                  message: "Thanks a bunch! Have a great day! 😊",
                  time: "10:25",
                  unreadCount: 3,
                ),
                ChatTile(
                    name: "Hari Karki",
                    message: "Great, thanks so much! 👋",
                    time: "22:20 05/05"),
                ChatTile(
                    name: "Angela Kelly",
                    message: "Appreciate it! See you soon! 🚀",
                    time: "10:45 08/05"),
                ChatTile(
                  name: "Bipasha Lamsal",
                  message: "Hooray! 🎉",
                  time: "20:10 05/05",
                ),
                ChatTile(
                  name: "Sita Karki",
                  message: "See you soon!",
                  time: "11:20 05/05",
                ),
              ],
            ),
          ),
          const BottomNavigationBarWidget(),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unreadCount;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.person, color: Colors.white),
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
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          if (unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Text(
                "$unreadCount",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // "Chats" button (current screen, active)
          const BottomNavItem(icon: Icons.chat, label: "Chats", isActive: true),
          // Navigate to GroupScreen
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const GroupMessageScreen()),
              );
            },
            child: const BottomNavItem(icon: Icons.group, label: "Groups"),
          ),
          // Navigate to ProfileScreen
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: const BottomNavItem(icon: Icons.person, label: "Profile"),
          ),
          // Navigate to SettingsScreen
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
