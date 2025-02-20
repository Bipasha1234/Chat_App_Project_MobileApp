import 'package:cool_app/app/di/di.dart';
import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:cool_app/features/chat/presentation/view/chat_view.dart';
import 'package:cool_app/features/chat/presentation/view/settings/settings_view.dart';
import 'package:cool_app/features/chat/presentation/view_model/chat/chat_bloc.dart';
import 'package:cool_app/features/home/presentation/view/bottom_view/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeState {
  final int selectedIndex;
  final List<Widget> views;
  final AuthEntity user; // Add user

  HomeState({
    required this.selectedIndex,
    required this.views,
    required this.user,
  });

  factory HomeState.initial(AuthEntity user) {
    return HomeState(
      selectedIndex: 0, // Default to the first tab
      user: user, // Store user details
      views: [
        BlocProvider(
          create: (context) => getIt<ChatBloc>(),
          child: const ChatView(),
        ),
        const Center(child: Text('Groups')),
        ProfileView(user: user), // Pass user to ProfileView
        BlocProvider(
          create: (context) => getIt<ChatBloc>(),
          child: const SettingsView(),
        ),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
    AuthEntity? user,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
      user: user ?? this.user,
    );
  }
}
