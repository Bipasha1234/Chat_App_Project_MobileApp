import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/use_case/block_user.dart';
import 'package:cool_app/features/chat/domain/use_case/delete_chat.dart';
import 'package:cool_app/features/chat/domain/use_case/get_block_users.dart';
import 'package:cool_app/features/chat/domain/use_case/get_messages.dart';
import 'package:cool_app/features/chat/domain/use_case/get_user_sidebar.dart';
import 'package:cool_app/features/chat/domain/use_case/send_message.dart';
import 'package:cool_app/features/chat/domain/use_case/unblock_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetUsersForSidebarUseCase _getUsersForSidebarUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final GetMessagesUseCase _getMessagesUseCase;
  final DeleteChatUsecase _deleteChatUsecase;
  final BlockUserUsecase _blockUserUsecase;
  final UnBlockUserUsecase _unblockUserUsecase;
  final GetBlockedUsersUseCase _getblockedUserUsecase;

  ChatBloc({
    required GetUsersForSidebarUseCase getUsersForSidebarUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required GetMessagesUseCase getMessagesUseCase,
    required DeleteChatUsecase deleteChatUsecase,
    required BlockUserUsecase blockUserUsecase,
    required UnBlockUserUsecase unblockUserUsecase,
    required GetBlockedUsersUseCase getblockedUserUsecase,
  })  : _getUsersForSidebarUseCase = getUsersForSidebarUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        _getMessagesUseCase = getMessagesUseCase,
        _deleteChatUsecase = deleteChatUsecase,
        _blockUserUsecase = blockUserUsecase,
        _unblockUserUsecase = unblockUserUsecase,
        _getblockedUserUsecase = getblockedUserUsecase,
        super(ChatState.initial()) {
    on<LoadGetUser>(_onLoadGetUser);
    on<SendMessage>(_onSendMessage);
    on<LoadMessages>(_onLoadMessages);
    on<DeleteChat>(_onDeleteChat);
    on<BlockUser>(_onBlockUser);
    on<UnBlockUser>(_onUnBlockUser);
    on<LoadBlockedUsers>(_onLoadBlockedUsers);
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

  Future<void> _onDeleteChat(DeleteChat event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await _deleteChatUsecase.call(DeleteChatParams(chatId: event.chatId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
      },
    );
  }

  Future<void> _onBlockUser(BlockUser event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await _blockUserUsecase.call(BlockUserParams(chatId: event.chatId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
      },
    );
  }

  Future<void> _onUnBlockUser(
      UnBlockUser event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await _unblockUserUsecase.call(UnBlockUserParams(chatId: event.chatId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
      },
    );
  }

  Future<void> _onLoadBlockedUsers(
      LoadBlockedUsers event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true)); // Show loading indicator

    try {
      final result = await _getblockedUserUsecase.call(); // Call use case

      result.fold(
        (failure) => emit(state.copyWith(
          isLoading: false,
          error: "Failed to load blocked users: ${failure.message}",
        )),
        (blockedUsers) => emit(state.copyWith(
          isLoading: false,
          blockedUsers:
              blockedUsers, // Update the state with the list of blocked users
          error: null, // Reset any previous error
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: "An unexpected error occurred while loading blocked users.",
      ));
      print("Error in _onLoadBlockedUsers: $e");
    }
  }
}
