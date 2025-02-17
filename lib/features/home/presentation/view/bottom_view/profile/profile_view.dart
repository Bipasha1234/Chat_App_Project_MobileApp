import 'dart:convert';
import 'dart:io';

import 'package:cool_app/app/constants/api_endpoints.dart';
import 'package:cool_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  final AuthEntity user;
  const ProfileView({super.key, required this.user});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isLoading = false;
  File? _image; // To hold the picked image
  late AuthEntity user; // To track the user data
  bool _isEditing = false; // To track editing state
  bool _isDataLoaded = false; // To track if data has been loaded

  @override
  void initState() {
    super.initState();
    user = widget.user;
    _nameController = TextEditingController(); // Initialize controllers here
    _emailController = TextEditingController();
    _loadUserData(); // Load the user data after initializing controllers
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String fullName = prefs.getString('fullName') ?? '';
    final String email = prefs.getString('email') ?? '';
    final String profilePic = prefs.getString('profilePic') ?? '';

    // Initialize controllers with the loaded data
    _nameController.text = fullName;
    _emailController.text = email;

    setState(() {
      _isDataLoaded = true; // Mark that data is loaded
    });
  }

  // Function to show the dialog for selecting camera or gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Show dialog to let the user select camera or gallery
    final pickedOption = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text('Gallery'),
          ),
        ],
      ),
    );

    if (pickedOption != null) {
      // Pick the image from the chosen source
      final pickedFile = await picker.pickImage(source: pickedOption);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path); // Store the selected image
        });
      }
    }
  }

  // Update Profile function
  Future<void> _updateProfile() async {
    setState(() => _isLoading = true);

    final tokenResult =
        await TokenSharedPrefs(await SharedPreferences.getInstance())
            .getToken();

    tokenResult.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error retrieving token: ${failure.message}')),
        );
        setState(() => _isLoading = false);
      },
      (token) async {
        try {
          var request = http.MultipartRequest(
            'PUT',
            Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.updateProfile}'),
          );

          request.headers.addAll({
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          });

          // Add text fields (name and email)
          request.fields['userId'] = user.userId ?? '';
          request.fields['fullName'] = _nameController.text;
          request.fields['email'] = _emailController.text;

          // If an image is picked, add it to the request
          if (_image != null) {
            request.files.add(
              await http.MultipartFile.fromPath('profilePicture', _image!.path),
            );
          }

          final response = await request.send();

          if (response.statusCode == 200) {
            final responseData =
                jsonDecode(await response.stream.bytesToString());

            // Create a new AuthEntity with updated details
            final updatedUser = AuthEntity(
              userId: user.userId,
              email: _emailController.text,
              fullName: _nameController.text,
              password: user.password,
              profilePic: _image != null
                  ? '${ApiEndpoints.imageUrl}${_image!.path.split('/').last}' // Set the correct image URL
                  : user.profilePic != null &&
                          user.profilePic!.startsWith('http')
                      ? user
                          .profilePic // If profilePic is already a full URL, keep it
                      : user
                          .profilePic, // If it's a path, just use it as is (without prepending imageUrl)
            );

            // Save updated user data to SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('fullName', updatedUser.fullName ?? '');
            prefs.setString('email', updatedUser.email ?? '');
            prefs.setString('profilePic', updatedUser.profilePic ?? '');

            // Update the local user details with the new user
            setState(() {
              user =
                  updatedUser; // This updates the UI immediately with the new user data
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(responseData['message'] ??
                      'Profile updated successfully!')),
            );
          } else {
            final errorMessage = await response.stream.bytesToString();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $errorMessage')),
            );
          }
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to update profile. Try again!')),
          );
        }

        setState(() => _isLoading = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none, // This allows the icon to go outside
              children: [
                GestureDetector(
                  onTap: _pickImage, // Open image picker when clicked
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : (user.profilePic != null &&
                                user.profilePic!.isNotEmpty)
                            ? NetworkImage(
                                '${ApiEndpoints.imageUrl}${user.profilePic!}') // Use profilePic from ApiEndpoints
                            : const AssetImage('assets/images/user.png')
                                as ImageProvider,
                  ),
                ),
                Positioned(
                  bottom: -3,
                  right: -1,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: const Icon(
                      Icons.camera_alt,
                      color: Color.fromARGB(255, 58, 172, 134),
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Click the camera icon to update the photo',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            // Conditionally show the edit fields
            Column(
              children: [
                // Full Name TextField
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        readOnly: !_isEditing,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    if (!_isEditing)
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            _isEditing = true;
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                // Email TextField
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _emailController,
                        readOnly: !_isEditing,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    if (!_isEditing)
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            _isEditing = true;
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                // Show Save Changes Button only when editing
                if (_isEditing)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _updateProfile,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Update Profile'),
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
