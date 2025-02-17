import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/use_case/get_user_sidebar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetUsersForSidebarUseCase _getUsersForSidebarUseCase;

  ChatBloc({
    required GetUsersForSidebarUseCase
        getUsersForSidebarUseCase, // Inject the use case
  })  : _getUsersForSidebarUseCase = getUsersForSidebarUseCase, // Initialize it
        super(ChatState.initial()) {
    on<LoadGetUser>(_onLoadGetUser);
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
}
