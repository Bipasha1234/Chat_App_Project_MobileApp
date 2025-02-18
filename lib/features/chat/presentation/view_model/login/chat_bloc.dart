import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/use_case/get_user_sidebar.dart';
import 'package:cool_app/features/chat/domain/use_case/send_message.dart'; // Import the SendMessageUseCase
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetUsersForSidebarUseCase _getUsersForSidebarUseCase;
  final SendMessageUseCase _sendMessageUseCase;

  ChatBloc({
    required GetUsersForSidebarUseCase getUsersForSidebarUseCase,
    required SendMessageUseCase sendMessageUseCase,
  })  : _getUsersForSidebarUseCase = getUsersForSidebarUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        super(ChatState.initial()) {
    on<LoadGetUser>(_onLoadGetUser);
    on<SendMessage>(_onSendMessage); // Listen for sending message event
  }

  Future<void> _onLoadGetUser(
      LoadGetUser event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getUsersForSidebarUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (users) => emit(state.copyWith(isLoading: false, users: users)),
    );
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isSending: true)); // Set loading state when sending

    final result =
        await _sendMessageUseCase.call(event.chatEntity); // Send message
    result.fold(
      (failure) => emit(state.copyWith(
          isSending: false, error: failure.message)), // Handle error
      (success) {
        // Update state for success
        emit(state.copyWith(
          isSending: false,
          sendMessageSuccess: true,
          messages: List.from(state.messages)
            ..add(event.chatEntity), // Add message to existing messages
        ));
      },
    );
  }
}
