// import 'package:flutter/material.dart';

// class ForgotPasswordScreenScreen extends StatefulWidget {
//   const ForgotPasswordScreenScreen({super.key});

//   @override
//   _ForgotPasswordScreenScreenState createState() => _ForgotPasswordScreenScreenState();
// }

// class _ForgotPasswordScreenScreenState extends State<ForgotPasswordScreenScreen> {
//   final _currentPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _reEnterPasswordController = TextEditingController();

//   String storedPassword = "currentPassword123";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColor,
//         title: const Text(
//           "Forgot Password",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pushNamed(context, '/signin');
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Change your password",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _currentPasswordController,
//               decoration: const InputDecoration(
//                 labelText: "Current Password",
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _newPasswordController,
//               decoration: const InputDecoration(
//                 labelText: "New Password",
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _reEnterPasswordController,
//               decoration: const InputDecoration(
//                 labelText: "Re-enter New Password",
//               ),
//             ),
//             const SizedBox(height: 40),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/signin');
//                 },
//                 child: const Text(
//                   "Change Password",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Email Verification",
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
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Enter your email",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              // Email Field
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),
              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/otp');
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
