import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _reEnterPasswordController = TextEditingController();

  String storedPassword =
      "currentPassword123"; // Replace with actual stored password

  void _changePassword() {
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String reEnterPassword = _reEnterPasswordController.text;

    if (currentPassword != storedPassword) {
      _showErrorDialog("Current password is incorrect!");
    } else if (newPassword != reEnterPassword) {
      _showErrorDialog("New passwords do not match!");
    } else if (newPassword.length < 6) {
      _showErrorDialog("New password must be at least 6 characters long!");
    } else {
      // Update password logic here (e.g., in database)
      _showSuccessDialog("Password successfully changed!");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Optionally, navigate to login screen or home screen after success
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Forgot Password",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/signin');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Change your password",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _currentPasswordController,
              decoration: const InputDecoration(
                labelText: "Current Password",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(
                labelText: "New Password",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _reEnterPasswordController,
              decoration: const InputDecoration(
                labelText: "Re-enter New Password",
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                },
                child: const Text(
                  "Change Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
