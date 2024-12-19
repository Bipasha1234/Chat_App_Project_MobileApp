import 'package:cool_app/view/pin_security.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const greenTheme = Color(0xFF80CBB2);

    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Check if the device is a tablet
    final isTablet = screenWidth > 600; // Define tablet breakpoint

    // Dynamic max width for fields
    final maxWidth = isTablet ? 500.0 : double.infinity;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: greenTheme,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Set Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Center the content
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0)
                      .copyWith(
                          top: screenHeight * 0.02), // Add padding at the top
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.03),

                      // Profile Avatar with Edit Icon
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: isTablet ? 70.0 : 50.0,
                            backgroundColor: greenTheme,
                            child: Icon(
                              Icons.person,
                              size: isTablet ? 70.0 : 50.0,
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
                                  color: greenTheme,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Name Field
                      _buildTextField("Name", isTablet, greenTheme),
                      SizedBox(height: screenHeight * 0.02),

                      // Phone Number Field
                      _buildTextField("Phone Number", isTablet, greenTheme,
                          keyboardType: TextInputType.phone),
                      SizedBox(height: screenHeight * 0.02),

                      // Gender Dropdown
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Gender",
                          labelStyle: TextStyle(
                            fontSize: isTablet ? 18.0 : 16.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: greenTheme),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: greenTheme),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("Male")),
                          DropdownMenuItem(
                              value: "Female", child: Text("Female")),
                          DropdownMenuItem(
                              value: "Other", child: Text("Other")),
                        ],
                        onChanged: (value) {
                          // Handle gender selection
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Email Field
                      _buildTextField("Email", isTablet, greenTheme,
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(height: screenHeight * 0.04),

                      // Full-width Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: isTablet ? 60.0 : 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to PIN Security Screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PinSecurityScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenTheme,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTablet ? 18.0 : 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create reusable TextFields
  Widget _buildTextField(String labelText, bool isTablet, Color greenTheme,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: isTablet ? 18.0 : 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: greenTheme),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: greenTheme),
        ),
      ),
    );
  }
}
