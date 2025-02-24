part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final bool isLoading;
  final bool isSending;
  final bool isLoadingMessages;
  final bool sendMessageSuccess;
  final String? error;
  final List<ChatEntity> users;
  final List<ChatEntity> messages;
  final List<ChatEntity> blockedUsers; // Add blocked users

  const ChatState({
    required this.isLoading,
    required this.isSending,
    required this.isLoadingMessages,
    required this.sendMessageSuccess,
    required this.error,
    required this.users,
    required this.messages,
    required this.blockedUsers, // Initialize blocked users
  });

  factory ChatState.initial() {
    return const ChatState(
      isLoading: false,
      isSending: false,
      isLoadingMessages: false,
      sendMessageSuccess: false,
      error: null,
      users: [],
      messages: [],
      blockedUsers: [], // Initialize as empty
    );
  }

  ChatState copyWith({
    bool? isLoading,
    bool? isSending,
    bool? isLoadingMessages,
    bool? sendMessageSuccess,
    String? error,
    List<ChatEntity>? users,
    List<ChatEntity>? messages,
    List<ChatEntity>? blockedUsers, // Add blockedUsers parameter
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      isLoadingMessages: isLoadingMessages ?? this.isLoadingMessages,
      sendMessageSuccess: sendMessageSuccess ?? this.sendMessageSuccess,
      error: error,
      users: users ?? this.users,
      messages: messages ?? this.messages,
      blockedUsers:
          blockedUsers ?? this.blockedUsers, // Update the list of blocked users
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSending,
        isLoadingMessages,
        sendMessageSuccess,
        error,
        users,
        messages,
        blockedUsers
      ];
}
