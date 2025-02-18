import 'package:cool_app/app/constants/hive_table_constant.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'chat_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.chatTableId)
class ChatHiveModel extends Equatable {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String senderId; // Added senderId field
  @HiveField(2)
  final String receiverId; // Added receiverId field
  @HiveField(3)
  final String fullName;
  @HiveField(4)
  final String? profilePic;
  @HiveField(5)
  final String latestMessage;
  @HiveField(6)
  final DateTime? lastMessageTime;

  // Added message content fields
  @HiveField(7)
  final String? text; // Text content of the message
  @HiveField(8)
  final String? image; // Image URL if an image is sent
  @HiveField(9)
  final String? audio; // Audio URL if an audio file is sent
  @HiveField(10)
  final String? document; // Document URL if a document is sent
  @HiveField(11)
  final String? documentName; // Document name if a document is sent

  const ChatHiveModel({
    required this.userId,
    required this.senderId, // Added senderId to constructor
    required this.receiverId, // Added receiverId to constructor
    required this.fullName,
    this.profilePic,
    this.latestMessage = "No message",
    this.lastMessageTime,
    this.text,
    this.image,
    this.audio,
    this.document,
    this.documentName,
  });

  // Initial Constructor
  const ChatHiveModel.initial()
      : userId = '',
        senderId = '',
        receiverId = '',
        fullName = '',
        profilePic = null,
        latestMessage = "No message",
        lastMessageTime = null,
        text = null,
        image = null,
        audio = null,
        document = null,
        documentName = null;

  // From Entity
  factory ChatHiveModel.fromEntity(ChatEntity entity) {
    return ChatHiveModel(
      userId: entity.userId,
      senderId: entity.senderId, // Mapping senderId from entity
      receiverId: entity.receiverId, // Mapping receiverId from entity
      fullName: entity.fullName,
      profilePic: entity.profilePic.isEmpty ? null : entity.profilePic,
      latestMessage: entity.latestMessage,
      lastMessageTime: entity.lastMessageTime,
      text: entity.text,
      image: entity.image,
      audio: entity.audio,
      document: entity.document,
      documentName: entity.documentName,
    );
  }

  // To Entity
  ChatEntity toEntity() {
    return ChatEntity(
      userId: userId,
      senderId: senderId, // Added senderId to entity conversion
      receiverId: receiverId, // Added receiverId to entity conversion
      fullName: fullName,
      profilePic: profilePic ?? '',
      latestMessage: latestMessage,
      lastMessageTime: lastMessageTime,
      text: text,
      image: image,
      audio: audio,
      document: document,
      documentName: documentName,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        senderId, // Include senderId in equality check
        receiverId, // Include receiverId in equality check
        fullName,
        profilePic,
        latestMessage,
        lastMessageTime,
        text,
        image,
        audio,
        document,
        documentName,
      ];
}
