// import 'package:cool_app/app/constants/api_endpoints.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserSharedPrefs {
//   final SharedPreferences _sharedPreferences;

//   UserSharedPrefs(this._sharedPreferences);

//   /// Save user data, ensuring profile picture URL is complete.
//   Future<void> saveUserData(
//       String email, String fullName, String profilePic) async {
//     // Ensure full image URL is stored
//     final String fullProfilePicUrl = profilePic.startsWith('http')
//         ? profilePic // If already a full URL, keep it
//         : "${ApiEndpoints.imageUrl}$profilePic"; // Append base URL if needed

//     await _sharedPreferences.setString('email', email);
//     await _sharedPreferences.setString('fullName', fullName);
//     await _sharedPreferences.setString('profilePic', fullProfilePicUrl);
//   }

//   /// Retrieve user data from shared preferences.
//   Map<String, String?> getUserData() {
//     String? email = _sharedPreferences.getString('email');
//     String? fullName = _sharedPreferences.getString('fullName');
//     String? profilePic = _sharedPreferences.getString('profilePic');

//     // If profilePic is not a full URL, append base URL
//     if (profilePic != null && !profilePic.startsWith('http')) {
//       profilePic = "${ApiEndpoints.imageUrl}$profilePic";
//     }

//     return {
//       'email': email,
//       'fullName': fullName,
//       'profilePic': profilePic,
//     };
//   }
// }
