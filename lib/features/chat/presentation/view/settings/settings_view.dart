import 'package:cool_app/app/di/di.dart';
import 'package:cool_app/core/common/snackbar/my_snackbar.dart';
import 'package:cool_app/features/chat/presentation/view/settings/blockedUsers.dart';
import 'package:cool_app/features/chat/presentation/view_model/chat/chat_bloc.dart';
import 'package:cool_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[50], // Subtle background color for the body
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  SizedBox(width: 8),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Blocked Users Section
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BlocProvider(
                          create: (context) => getIt<ChatBloc>(),
                          child: const BlockedUsersPage(),
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.block, // Blocked user icon
                            color: Colors.red, // Red color for the icon
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Blocked Users',
                            style: TextStyle(
                              color: Colors.red, // Red color for the text
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios, // Right arrow icon
                        color: Colors.black54,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Logout Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showMySnackBar(
                      context: context,
                      message: 'Logging out...',
                      color: Colors.red,
                    );
                    context.read<HomeCubit>().logout(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Red color for the button
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize
                        .min, // To ensure text and icon are side by side
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white, // White color for the icon
                      ),
                      SizedBox(width: 8), // Space between icon and text
                      Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
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
