import 'package:cool_app/view/login.dart'; // Import the OnboardingScreen
import 'package:cool_app/view/onboarding_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF80CBB2), // Set AppBar color
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Back arrow icon
            color: Colors.white, // Set icon color to white
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OnboardingScreen()), // Navigate to OnboardingScreen
            );
          },
        ),
        title: const Text(
          "Register", // Title of the screen
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Create a New Account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              
              // Username Field
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: "Username"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  // Regular expression for validating email
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Register Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Proceed with registration
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registering...')),
                    );
                    // You can add logic to handle registration here.
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF80CBB2), // Set button color to green
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white,fontSize:18), // Text color white
                ),
              ),
              SizedBox(height: 20),

              // Navigate to Login Screen
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to LoginScreen
                  );
                },
                child: Text(
            'Already have an account? Login',
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.underline, // Set text color to black
            ),
          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
