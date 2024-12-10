import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF80CBB2), // AppBar color
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Back arrow icon
            color: Colors.white, // White color for the arrow
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: const Text("Chats"), // App title
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white), // Search icon
            onPressed: () {
              // Add search functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white), // Plus icon
            onPressed: () {
              // Add functionality for adding items here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 4, // Number of chat items
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/image2.jpg'), // Replace with actual image path
            ),
            title: Text(
              'User ${index + 1}', // Username
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'This is a message preview for User ${index + 1}', // Message preview
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Text(
              '12:30 PM', // Time or date
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on User ${index + 1}')),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF80CBB2), // Highlight color
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble), // Icon for Chats
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group), // Icon for Groups
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Icon for Profile
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // Icon for Settings
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          // Handle navigation or actions for each button
          switch (index) {
            case 0:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Chats selected')),
              );
              break;
            case 1:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Groups selected')),
              );
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile selected')),
              );
              break;
            case 3:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings selected')),
              );
              break;
          }
        },
      ),
    );
  }
}
