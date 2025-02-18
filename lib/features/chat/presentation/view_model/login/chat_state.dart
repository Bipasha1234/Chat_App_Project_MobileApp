part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final bool isLoading;
  final bool isSending;
  final bool sendMessageSuccess;
  final bool isNavigating; // Track navigation state
  final List<ChatEntity> users;
  final List<ChatEntity> messages; // Added messages field
  final String? error;

  const ChatState({
    required this.isLoading,
    required this.isSending,
    required this.sendMessageSuccess,
    required this.isNavigating,
    required this.users,
    required this.messages, // Initialize messages
    this.error,
  });

  factory ChatState.initial() {
    return const ChatState(
      isLoading: false,
      isSending: false,
      sendMessageSuccess: false,
      isNavigating: false,
      users: [],
      messages: [], // Initialize messages as empty list
      error: null,
    );
  }

  ChatState copyWith({
    bool? isLoading,
    bool? isSending,
    bool? sendMessageSuccess,
    bool? isNavigating,
    List<ChatEntity>? users,
    List<ChatEntity>? messages, // Add messages in copyWith
    String? error,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      sendMessageSuccess: sendMessageSuccess ?? this.sendMessageSuccess,
      isNavigating: isNavigating ?? this.isNavigating,
      users: users ?? this.users,
      messages: messages ?? this.messages, // Add messages here
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSending,
        sendMessageSuccess,
        isNavigating,
        users,
        messages,
        error
      ];
}
