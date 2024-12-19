import 'package:cool_app/view/onboarding_screen.dart';
import 'package:cool_app/view/otp_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF80CBB2),
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingScreen(),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Add the image here
            Image.asset(
              'assets/images/chattix.png',
              height: 150,
            ),
            const SizedBox(height: 40),
            const Text(
              "Enter Your Phone Number",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: screenWidth > 600 ? 400 : double.infinity,
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 22, 129, 94)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 112, 144, 112)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: _errorMessage,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "You will get an OTP via your phone number.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: screenWidth > 600 ? 400 : double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final phone = phoneController.text.trim();
                    if (phone.isNotEmpty &&
                        RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
                      setState(() {
                        _errorMessage = null;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtpScreen(email: phone)),
                      );
                    } else {
                      setState(() {
                        _errorMessage = "Please enter a valid phone number.";
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF80CBB2),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
