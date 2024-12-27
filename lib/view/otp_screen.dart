import 'dart:async';

import 'package:cool_app/view/dashboard.dart';
import 'package:flutter/material.dart';

import 'otp_input_field.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController()); // Updated to 6
  late Timer _timer;
  int _remainingTime = 60;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          "OTP Verification",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
            fontSize: isTablet ? 24 : 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: theme.colorScheme.onPrimary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 30 : 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter the provided OTP",
              style: TextStyle(
                fontSize: isTablet ? 24 : 21,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Sent to: ${widget.email}",
              style: TextStyle(
                  fontSize: isTablet ? 18 : 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "0:${_remainingTime.toString().padLeft(2, '0')}",
                  style: TextStyle(
                      fontSize: isTablet ? 20 : 16, color: Colors.grey[600]),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _remainingTime == 0
                      ? () {
                          setState(() {
                            _remainingTime = 45;
                          });
                          _startTimer();
                        }
                      : null,
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 16,
                      color: _remainingTime == 0
                          ? theme.primaryColor
                          : theme.disabledColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Reusable OTP Input Field
            OtpInputField(controllers: _otpControllers, isTablet: isTablet),

            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  _errorMessage!,
                  style:
                      TextStyle(color: theme.colorScheme.error, fontSize: 14),
                ),
              ),
            const SizedBox(height: 30),
            SizedBox(
              width: screenWidth > 600 ? 400 : double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatScreen()),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
