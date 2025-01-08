import 'package:cool_app/model/chat_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<Chat> chats;

  ChatLoadedState({required this.chats});

  @override
  List<Object?> get props => [chats];
}

class ChatErrorState extends ChatState {
  final String errorMessage;

  ChatErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
