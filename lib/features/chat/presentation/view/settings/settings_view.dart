import 'package:cool_app/app/di/di.dart';
import 'package:cool_app/core/common/snackbar/my_snackbar.dart';
import 'package:cool_app/core/theme/theme_cubit.dart';
import 'package:cool_app/features/chat/presentation/view/settings/blockedUsers.dart';
import 'package:cool_app/features/chat/presentation/view_model/chat/chat_bloc.dart';
import 'package:cool_app/features/home/presentation/view_model/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 20, 20, 20)
            : const Color.fromARGB(255, 117, 198, 171),
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      body: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          bool isDarkMode = theme.brightness == Brightness.dark;
          return Container(
            color: isDarkMode
                ? Colors.black12
                : Colors.grey[50], // Dynamic background
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),

                // Change Theme Section with Light and Dark theme labels
                const Text(
                  "Change Theme",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                // Light Theme, Toggle, and Dark Theme section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Light Theme",
                      style: TextStyle(fontSize: 16),
                    ),
                    Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        context.read<ThemeCubit>().toggleTheme(value);
                      },
                    ),
                    const Text(
                      "Dark Theme",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 25), // Add space between sections

                // Divider to separate sections
                Divider(
                  color: isDarkMode ? Colors.white70 : Colors.black12,
                  thickness: 1,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        if (!isDarkMode) // Only show shadow in light mode
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.block,
                                color:
                                    isDarkMode ? Colors.redAccent : Colors.red),
                            const SizedBox(width: 8),
                            Text(
                              'Blocked Users',
                              style: TextStyle(
                                color:
                                    isDarkMode ? Colors.redAccent : Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                            size: 20),
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
                      backgroundColor:
                          isDarkMode ? Colors.redAccent : Colors.red,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Logout', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
