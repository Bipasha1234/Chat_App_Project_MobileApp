import 'package:cool_app/view/dashboard.dart';
import 'package:flutter/material.dart';

import 'otp_input_field.dart'; // Import the reusable OTP field widget

class PinSecurityScreen extends StatelessWidget {
  const PinSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const greenTheme = Color(0xFF80CBB2);

    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    // Dynamic sizes
    final fieldWidth = isTablet ? 70.0 : 60.0;
    final buttonWidth = isTablet ? 160.0 : 120.0;
    final fontSize = isTablet ? 18.0 : 16.0;

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
          "PIN Security",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image widget
            Image.asset(
              'assets/images/image.png', // Replace with your image path
              width: isTablet ? 120.0 : 100.0,
              height: isTablet ? 120.0 : 100.0,
            ),
            const SizedBox(height: 20),

            // Instruction Text
            Text(
              "Protect your account with a secure PIN",
              style: TextStyle(fontSize: fontSize, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // PIN Input Fields
            OtpInputField(
                controllers:
                    List.generate(4, (index) => TextEditingController()),
                isTablet: isTablet),
            const SizedBox(
                height: 50), // Increased gap between PIN boxes and buttons

            // Skip and Continue Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Skip Button
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Skip
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: greenTheme, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Skip",
                      style: TextStyle(color: greenTheme, fontSize: fontSize),
                    ),
                  ),
                ),
                const SizedBox(
                    width: 20), // Reduced gap between Skip and Continue

                // Continue Button
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Dashboard
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenTheme,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: fontSize),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
