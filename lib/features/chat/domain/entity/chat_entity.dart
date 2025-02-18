import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String userId; // ID of the user whose chat is being displayed
  final String senderId; // ID of the user who sent the latest message
  final String receiverId; // ID of the user who received the latest message
  final String fullName; // Full name of the user
  final String profilePic; // Profile picture URL of the user
  final String latestMessage; // Latest message text
  final DateTime? lastMessageTime; // Timestamp of the latest message
  final bool isSeen; // Whether the message has been seen
  final List<String> deletedBy; // List of users who deleted the message
  final String? text; // Text content of the message
  final String? image; // Image URL if an image is sent
  final String? audio; // Audio URL if an audio file is sent
  final String? document; // Document URL if a document is sent
  final String? documentName; // Document name if a document is sent

  const ChatEntity({
    required this.userId,
    required this.senderId, // Sender's ID
    required this.receiverId, // Receiver's ID
    required this.fullName,
    required this.profilePic,
    this.latestMessage = "No message", // Default message if none exists
    this.lastMessageTime,
    this.isSeen = false, // Default value for read status
    this.deletedBy = const [], // Default empty list for deletedBy
    this.text, // Optional text field
    this.image, // Optional image URL
    this.audio, // Optional audio URL
    this.document, // Optional document URL
    this.documentName, // Optional document name
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
      latestMessage: latestMessage,
      lastMessageTime: lastMessageTime,
      isSeen: isSeen,
      deletedBy: updatedDeletedBy,
      text: text,
      image: image,
      audio: audio,
      document: document,
      documentName: documentName,
    );
  }

  // Method to mark a message as read
  ChatEntity markAsSeen() {
    return ChatEntity(
      userId: userId,
      senderId: senderId,
      receiverId: receiverId,
      fullName: fullName,
      profilePic: profilePic,
      latestMessage: latestMessage,
      lastMessageTime: lastMessageTime,
      isSeen: true,
      deletedBy: deletedBy,
      text: text,
      image: image,
      audio: audio,
      document: document,
      documentName: documentName,
    );
  }
}
