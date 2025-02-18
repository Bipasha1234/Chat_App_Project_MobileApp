part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadGetUser extends ChatEvent {}

class SendMessage extends ChatEvent {
  final ChatEntity chatEntity;

  const SendMessage({required this.chatEntity});

  @override
  List<Object> get props => [chatEntity];
}
