import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/use_case/get_messages.dart';
import 'package:cool_app/features/chat/domain/use_case/get_user_sidebar.dart';
import 'package:cool_app/features/chat/domain/use_case/send_message.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetUsersForSidebarUseCase _getUsersForSidebarUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final GetMessagesUseCase _getMessagesUseCase;

  ChatBloc({
    required GetUsersForSidebarUseCase getUsersForSidebarUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required GetMessagesUseCase getMessagesUseCase,
  })  : _getUsersForSidebarUseCase = getUsersForSidebarUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        _getMessagesUseCase = getMessagesUseCase,
        super(ChatState.initial()) {
    on<LoadGetUser>(_onLoadGetUser);
    on<SendMessage>(_onSendMessage);
    on<LoadMessages>(_onLoadMessages);
  }

  // Loading users with improved error handling
  Future<void> _onLoadGetUser(
      LoadGetUser event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final result = await _getUsersForSidebarUseCase.call();
      result.fold(
        (failure) => emit(state.copyWith(
          isLoading: false,
          error: "Failed to load users: ${failure.message}",
        )),
        (users) => emit(state.copyWith(
          isLoading: false,
          users: users,
          error: null, // Reset any error message on success
        )),
      );
    } catch (e) {
      // Catch any other exceptions and emit an error state
      emit(state.copyWith(
        isLoading: false,
        error: "An unexpected error occurred while loading users.",
      ));
      print("Error in _onLoadGetUser: $e");
    }
  }

  // Sending message with improved error handling
  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isSending: true));

    try {
      final result = await _sendMessageUseCase.call(event.chatEntity);
      result.fold(
        (failure) => emit(state.copyWith(
          isSending: false,
          error: "Failed to send message: ${failure.message}",
        )),
        (success) {
          emit(state.copyWith(
            isSending: false,
            sendMessageSuccess: true,
            messages: List.from(state.messages)..add(event.chatEntity),
            error: null, // Reset error on success
          ));
        },
      );
    } catch (e) {
      // Catch any unexpected errors during message sending
      emit(state.copyWith(
        isSending: false,
        error: "An unexpected error occurred while sending the message.",
      ));
      print("Error in _onSendMessage: $e");
    }
  }

  // Loading messages with improved error handling
  Future<void> _onLoadMessages(
      LoadMessages event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoadingMessages: true));

    try {
      final result = await _getMessagesUseCase.call(
        GetMessagesParams(chatId: event.chatId),
      );
      result.fold(
        (failure) => emit(state.copyWith(
          isLoadingMessages: false,
          error: "Failed to load messages: ${failure.message}",
        )),
        (messages) => emit(state.copyWith(
          isLoadingMessages: false,
          messages: messages,
          error: null, // Reset error message on success
        )),
      );
    } catch (e) {
      // Catch any unexpected errors during message loading
      emit(state.copyWith(
        isLoadingMessages: false,
        error: "An unexpected error occurred while loading messages.",
      ));
      print("Error in _onLoadMessages: $e");
    }
  }
}
