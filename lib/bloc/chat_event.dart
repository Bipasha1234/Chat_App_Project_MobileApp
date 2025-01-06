import 'package:cool_app/model/chat_model.dart';

abstract class ChatEvent {}

class FetchChatsEvent extends ChatEvent {}

class AddChatEvent extends ChatEvent {
  final Chat chat;
  AddChatEvent({required this.chat});
}

class RemoveChatEvent extends ChatEvent {
  final String chatName;
  RemoveChatEvent({required this.chatName});
}
