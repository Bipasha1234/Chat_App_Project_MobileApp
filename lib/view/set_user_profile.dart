import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isTablet = screenWidth > 600;
    final maxWidth = isTablet ? 500.0 : double.infinity;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
        ),
        title: const Text(
          "Set Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0)
                  .copyWith(top: screenHeight * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.08),

                  // Profile Avatar with Edit Icon
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: isTablet ? 70.0 : 50.0,
                        backgroundColor: Theme.of(context).primaryColorLight,
                        child: Icon(
                          Icons.person,
                          size: isTablet ? 70.0 : 50.0,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Name Field
                  _buildTextField("Name"),
                  SizedBox(height: screenHeight * 0.02),

                  // Phone Number Field
                  _buildTextField("Phone Number",
                      keyboardType: TextInputType.phone),
                  SizedBox(height: screenHeight * 0.02),

                  // Gender Dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Gender",
                    ),
                    items: const [
                      DropdownMenuItem(value: "Male", child: Text("Male")),
                      DropdownMenuItem(value: "Female", child: Text("Female")),
                      DropdownMenuItem(value: "Other", child: Text("Other")),
                    ],
                    onChanged: (value) {
                      // Handle gender selection
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Email Field
                  _buildTextField("Email",
                      keyboardType: TextInputType.emailAddress),
                  SizedBox(height: screenHeight * 0.04),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/chat');
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
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
