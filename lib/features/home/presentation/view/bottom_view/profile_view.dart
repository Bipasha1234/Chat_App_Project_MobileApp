// // import 'package:cool_app/app/shared_prefs/user_shared_prefs.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({super.key});

// //   @override
// //   _ProfilePageState createState() => _ProfilePageState();
// // }

// // class _ProfilePageState extends State<ProfilePage> {
// //   String? _profilePicUrl;
// //   String? email;
// //   String? fullName;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadUserData();
// //   }

// //   // Load user data from shared preferences
// //   void _loadUserData() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     final userPrefs = UserSharedPrefs(prefs);
// //     final userData = userPrefs.getUserData();

// //     setState(() {
// //       email = userData['email'];
// //       fullName = userData['fullName'];
// //       _profilePicUrl = userData['profilePic'];
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Profile')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             // Display profile picture
// //             _profilePicUrl != null
// //                 ? CircleAvatar(
// //                     radius: 50,
// //                     backgroundImage: NetworkImage(_profilePicUrl!),
// //                     backgroundColor: Colors.grey[200],
// //                   )
// //                 : const CircularProgressIndicator(),
// //             const SizedBox(height: 16),
// //             Text(
// //               fullName ?? 'Loading...',
// //               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 8),
// //             Text(email ?? 'Loading...', style: const TextStyle(fontSize: 18)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   // Load profile data from SharedPreferences
//   Future<Map<String, String?>> loadProfile() async {
//     final sharedPreferences = await SharedPreferences.getInstance();

//     // Retrieve the saved user information
//     final fullName = sharedPreferences.getString('fullName');
//     final email = sharedPreferences.getString('email');
//     final profilePic = sharedPreferences.getString('profilePic');
//     final memberSince = sharedPreferences.getString('memberSince') ??
//         '2025-01-09'; // Default date
//     final accountStatus = sharedPreferences.getString('accountStatus') ??
//         'Active'; // Default status

//     // Base URL for profile pictures
//     const baseUrl = "http://10.0.2.2:3000/uploads/";

//     // If profilePic is not null or empty, prepend base URL
//     final fullProfilePicUrl = (profilePic != null && profilePic.isNotEmpty)
//         ? "$baseUrl$profilePic"
//         : null;

//     return {
//       'fullName': fullName,
//       'email': email,
//       'profilePic': fullProfilePicUrl, // Full URL for the profile picture
//       'memberSince': memberSince, // Member since date
//       'accountStatus': accountStatus, // Account status
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, String?>>(
//       future: loadProfile(), // Load profile data
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.hasError) {
//           return const Center(child: Text('Error loading profile'));
//         }

//         final data = snapshot.data;

//         if (data == null || data.isEmpty) {
//           return const Center(child: Text('No profile data available'));
//         }

//         return Scaffold(
//           appBar: AppBar(title: const Text('Profile')),
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // Display profile picture
//                 data['profilePic'] != null && data['profilePic']!.isNotEmpty
//                     ? CircleAvatar(
//                         radius: 50,
//                         backgroundImage: NetworkImage(data['profilePic']!),
//                         backgroundColor: Colors.grey[200],
//                       )
//                     : const CircleAvatar(
//                         radius: 50,
//                         backgroundImage: AssetImage(
//                             'assets/images/user.png'), // Default image
//                       ),
//                 const SizedBox(height: 20),

//                 // Display user full name
//                 Text(
//                   data['fullName'] ?? 'Full Name not available',
//                   style: const TextStyle(
//                       fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),

//                 // Display user email
//                 Text(
//                   data['email'] ?? 'Email not available',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 16),

//                 // Member Since Card
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListTile(
//                     title: const Text("Member Since"),
//                     subtitle: Text(data['memberSince'] ?? 'Not Available'),
//                   ),
//                 ),

//                 // Account Status Card
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListTile(
//                     title: const Text("Account Status"),
//                     subtitle: Text(
//                       data['accountStatus'] ?? 'Unknown',
//                       style: TextStyle(
//                           color: data['accountStatus'] == 'Active'
//                               ? Colors.green
//                               : Colors.red),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Logout Button
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add your logout functionality here
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 12),
//                   ),
//                   child: const Text("Logout",
//                       style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // import 'package:cool_app/app/shared_prefs/user_shared_prefs.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({super.key});

// //   @override
// //   _ProfilePageState createState() => _ProfilePageState();
// // }

// // class _ProfilePageState extends State<ProfilePage> {
// //   String? _profilePicUrl;
// //   String? email;
// //   String? fullName;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadUserData();
// //   }

// //   // Load user data from shared preferences
// //   void _loadUserData() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     final userPrefs = UserSharedPrefs(prefs);
// //     final userData = userPrefs.getUserData();

// //     setState(() {
// //       email = userData['email'];
// //       fullName = userData['fullName'];
// //       _profilePicUrl = userData['profilePic'];
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Profile')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             // Display profile picture
// //             _profilePicUrl != null
// //                 ? CircleAvatar(
// //                     radius: 50,
// //                     backgroundImage: NetworkImage(_profilePicUrl!),
// //                     backgroundColor: Colors.grey[200],
// //                   )
// //                 : const CircularProgressIndicator(),
// //             const SizedBox(height: 16),
// //             Text(
// //               fullName ?? 'Loading...',
// //               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 8),
// //             Text(email ?? 'Loading...', style: const TextStyle(fontSize: 18)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
// import 'package:flutter/material.dart';

// class ProfileView extends StatelessWidget {
//   final AuthEntity user;

//   const ProfileView(
//       {super.key, required this.user}); // Accept user data as parameter

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   // title: const Text('Profile'),
//       //   centerTitle: true,
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Full Name: ${user.fullName}',
//                 style: const TextStyle(fontSize: 20)),
//             Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement profile update or other actions if needed
//               },
//               child: const Text('Update Profile'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final AuthEntity user;
  final String baseUrl =
      'http://10.0.2.2:3000/uploads/'; // Replace with your actual base URL

  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    user.profilePic != null && user.profilePic!.isNotEmpty
                        ? NetworkImage('$baseUrl${user.profilePic}')
                        : const AssetImage('assets/images/user.png')
                            as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),
            Text('Full Name: ${user.fullName}',
                style: const TextStyle(fontSize: 20)),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement profile update or other actions if needed
              },
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
