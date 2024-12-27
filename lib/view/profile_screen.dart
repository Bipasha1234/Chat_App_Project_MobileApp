import 'package:cool_app/view/dashboard.dart';
import 'package:cool_app/view/group_screen.dart';
import 'package:cool_app/view/login.dart';
import 'package:cool_app/view/settings.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const greenTheme = Color(0xFF80CBB2);

    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF80CBB2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          // Ensure scrolling for smaller screens
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Avatar with Edit Icon
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: greenTheme,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: greenTheme, width: 2),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.edit,
                          color: Color(0xFF80CBB2),
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Bipasha Lamsal",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gender Section
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Gender: Female",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.black),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Phone Number Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Phone: 9841459951",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.black),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Email Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Email: bipashalamsal@gmail.com",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.black),
                          onPressed: () {
                            // Add copy logic here for email
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Buttons for Edit Profile and Logout with same width
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    // Adjust button width based on screen size
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF80CBB2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(
                          isTablet
                              ? screenWidth *
                                  0.35 // Slightly smaller for tablet
                              : double.infinity, // Full width for mobile
                          50, // Reduced height
                        ),
                      ),
                      onPressed: () {
                        // Add edit profile logic here
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 237, 137, 137),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(
                          isTablet
                              ? screenWidth *
                                  0.35 // Slightly smaller for tablet
                              : double.infinity, // Full width for mobile
                          50, // Reduced height
                        ),
                      ),
                      onPressed: () {
                        // Navigate to the LoginScreen when logout is clicked
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()),
                        );
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 2),
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
