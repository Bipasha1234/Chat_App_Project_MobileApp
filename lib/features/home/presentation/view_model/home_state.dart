import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:cool_app/features/home/presentation/view/bottom_view/chats_view.dart';
import 'package:cool_app/features/home/presentation/view/bottom_view/profile_view.dart';
import 'package:flutter/material.dart';

class HomeState {
  final int selectedIndex;
  final List<Widget> views;
  final AuthEntity user; // Add user

  HomeState(
      {required this.selectedIndex, required this.views, required this.user});

  factory HomeState.initial(AuthEntity user) {
    return HomeState(
      selectedIndex: 0, // Default to the first tab
      user: user, // Store user details
      views: [
        ChatsView(), // Chats tab view
        const Center(child: Text('Groups')),
        ProfileView(user: user), // Pass user to ProfileView
        const Center(child: Text('Settings')),
      ],
    );
  }

  HomeState copyWith(
      {int? selectedIndex, List<Widget>? views, AuthEntity? user}) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
      user: user ?? this.user,
    );
  }
}
