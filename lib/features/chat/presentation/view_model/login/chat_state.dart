part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<ChatEntity> users;
  final bool isLoading;
  final String? error;

  const ChatState({
    required this.users,
    required this.isLoading,
    this.error,
  });

  factory ChatState.initial() {
    return const ChatState(
      users: [],
      isLoading: false,
    );
  }

  ChatState copyWith({
    List<ChatEntity>? users,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [users, isLoading, error];
}
