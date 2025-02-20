part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadGetUser extends ChatEvent {}

class SendMessage extends ChatEvent {
  final ChatEntity chatEntity;

  SendMessage(this.chatEntity);

  @override
  List<Object?> get props => [chatEntity];
}

class LoadMessages extends ChatEvent {
  final String chatId;

  LoadMessages(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

final class DeleteChat extends ChatEvent {
  final String chatId;

  DeleteChat(this.chatId);

  @override
  List<Object> get props => [chatId];
}

final class BlockUser extends ChatEvent {
  final String chatId;

  BlockUser(this.chatId);

  @override
  List<Object> get props => [chatId];
}
