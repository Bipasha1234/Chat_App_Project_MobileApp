import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Avatar with Edit Icon
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: isTablet ? 70.0 : 50.0,
                        backgroundColor: Theme.of(context).primaryColor,
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
                  const SizedBox(height: 30),

                  _buildTextField("Name"),
                  const SizedBox(height: 20),

                  _buildTextField("Phone Number",
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Gender",
                    ),
                    items: const [
                      DropdownMenuItem(value: "Male", child: Text("Male")),
                      DropdownMenuItem(value: "Female", child: Text("Female")),
                      DropdownMenuItem(value: "Other", child: Text("Other")),
                    ],
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 20),

                  _buildTextField("Email",
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 40),

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
