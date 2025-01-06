import 'package:cool_app/model/chat_model.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<Chat> chats;
  ChatLoadedState({required this.chats});
}

class ChatErrorState extends ChatState {
  final String errorMessage;
  ChatErrorState({required this.errorMessage});
}
