import 'package:cool_app/core/theme/theme_cubit.dart';
import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:cool_app/features/home/presentation/view_model/home_bloc.dart';
import 'package:cool_app/features/home/presentation/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  final AuthEntity user;

  const HomeView({super.key, required this.user}); // Pass user data to HomeView

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(user), // Initialize HomeCubit with user
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, theme) {
              bool isDarkMode = theme.brightness == Brightness.dark;

              return Scaffold(
                backgroundColor: const Color.fromARGB(
                    255, 117, 198, 171), // Main background color
                body: state.views[state.selectedIndex], // Show the selected tab
                bottomNavigationBar: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.chat), label: 'Chats'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.face), label: 'Profile'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings'),
                  ],
                  currentIndex: state.selectedIndex,
                  selectedItemColor: isDarkMode
                      ? Colors.white
                      : Colors.white, // Color based on theme
                  unselectedItemColor: isDarkMode
                      ? Colors.grey[500]
                      : Colors.grey[700], // Unselected color
                  backgroundColor: isDarkMode
                      ? Colors.grey[
                          900] // Dark mode bottom nav bar background color
                      : const Color(
                          0xFF80CBB2), // Light mode bottom nav bar background color
                  onTap: (index) =>
                      context.read<HomeCubit>().onTabTapped(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
