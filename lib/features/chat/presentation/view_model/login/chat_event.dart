part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

final class LoadGetUser extends ChatEvent {}
