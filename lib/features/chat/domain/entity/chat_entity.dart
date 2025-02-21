import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String userId;
  final String senderId;
  final String receiverId;
  final String fullName;
  final String profilePic;
  final String latestMessage;
  final DateTime? lastMessageTime;
  final bool isSeen;
  final List<String> deletedBy;
  final String? text;
  final String? image;
  final String? audio;
  final String? document;
  final String? documentName;
  final DateTime? createdAt;
  final String? email;

  const ChatEntity({
    required this.userId,
    required this.senderId,
    required this.receiverId,
    required this.fullName,
    required this.profilePic,
    this.email,
    this.latestMessage = "No message",
    this.lastMessageTime,
    this.isSeen = false,
    this.deletedBy = const [],
    this.text,
    this.image,
    this.audio,
    this.document,
    this.documentName,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        userId,
        senderId,
        receiverId,
        fullName,
        profilePic,
        latestMessage,
        lastMessageTime,
        isSeen,
        deletedBy,
        text,
        image,
        audio,
        document,
        documentName,
        createdAt,
        email,
      ];

  // Method to handle deletion of message
  ChatEntity markAsDeleted(String userId) {
    final updatedDeletedBy = List<String>.from(deletedBy)..add(userId);
    return ChatEntity(
      userId: userId,
      senderId: senderId,
      receiverId: receiverId,
      fullName: fullName,
      profilePic: profilePic,
      email: email,
      latestMessage: latestMessage,
      lastMessageTime: lastMessageTime,
      isSeen: isSeen,
      deletedBy: updatedDeletedBy,
      text: text,
      image: image,
      audio: audio,
      document: document,
      documentName: documentName,
      createdAt: createdAt,
    );
  }

  ChatEntity markAsSeen() {
    return ChatEntity(
      userId: userId,
      senderId: senderId,
      receiverId: receiverId,
      fullName: fullName,
      profilePic: profilePic,
      email: email,
      latestMessage: latestMessage,
      lastMessageTime: lastMessageTime,
      isSeen: true,
      deletedBy: deletedBy,
      text: text,
      image: image,
      audio: audio,
      document: document,
      documentName: documentName,
      createdAt: createdAt,
    );
  }
}
