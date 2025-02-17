import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String userId;
  final String fullname;
  final String profilePic;
  final String latestMessage;
  final String messageTimestamp;

  const ChatEntity({
    required this.userId,
    required this.fullname,
    required this.profilePic,
    this.latestMessage = "No message",
    this.messageTimestamp = "",
  });

  @override
  List<Object?> get props => [
        userId,
        fullname,
        profilePic,
        latestMessage,
        messageTimestamp,
      ];
}
