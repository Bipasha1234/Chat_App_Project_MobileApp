import 'package:cool_app/features/home/presentation/view/bottom_view/chats_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// HomeState class for state management
class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        ChatsView(), // Chats tab view
        const Center(child: Text('Groups')),
        const Center(child: Text('Profile')),
        const Center(child: Text('Settings')),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
