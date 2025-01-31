// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfileView extends StatefulWidget {
//   const ProfileView({super.key});

//   @override
//   _ProfileViewState createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   String email = '';
//   String fullName = '';
//   String profilePic = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   _loadUserData() async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     final email = sharedPreferences.getString('email') ?? '';
//     final fullName = sharedPreferences.getString('fullName') ?? '';
//     final profilePic = sharedPreferences.getString('profilePic') ?? '';

//     print('Loaded Profile Pic URL: $profilePic'); // Debugging line

//     setState(() {
//       this.email = email;
//       this.fullName = fullName;
//       this.profilePic = profilePic;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             // Profile Picture
//             // CircleAvatar(
//             //   radius: 100,
//             //   backgroundImage: profilePic.isNotEmpty
//             //       ? (profilePic.startsWith('http')
//             //           ? NetworkImage(profilePic) // If URL, use NetworkImage
//             //           : FileImage(
//             //               File(profilePic))) // If local file, use FileImage
//             //       : const AssetImage(
//             //           "assets/images/user.png"), // Default image if no profile pic
//             // ),
//             const SizedBox(height: 20),
//             // Full Name
//             Text(
//               fullName.isEmpty ? 'No Name' : fullName,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             // Email
//             Text(
//               email.isEmpty ? 'No Email' : email,
//               style: const TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
