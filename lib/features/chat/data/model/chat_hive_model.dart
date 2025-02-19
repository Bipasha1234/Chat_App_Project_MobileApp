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
  final String senderId;
  @HiveField(2)
  final String receiverId;
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
  final String? text;
  @HiveField(8)
  final String? image;
  @HiveField(9)
  final String? audio;
  @HiveField(10)
  final String? document;
  @HiveField(11)
  final String? documentName;

  @HiveField(12)
  final DateTime? createdAt;

  @HiveField(13)
  final String? email; // Added email field

  const ChatHiveModel({
    required this.userId,
    required this.senderId,
    required this.receiverId,
    required this.fullName,
    this.profilePic,
    this.latestMessage = "No message",
    this.lastMessageTime,
    this.text,
    this.image,
    this.audio,
    this.document,
    this.documentName,
    this.createdAt,
    this.email, // Added email to constructor
  });

  // Initial Constructor
  ChatHiveModel.initial()
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
        documentName = null,
        createdAt = DateTime.now(),
        email = null; // Set initial value for email

  // From Entity
  factory ChatHiveModel.fromEntity(ChatEntity entity) {
    return ChatHiveModel(
      userId: entity.userId,
      senderId: entity.senderId,
      receiverId: entity.receiverId,
      fullName: entity.fullName,
      profilePic: entity.profilePic.isEmpty ? null : entity.profilePic,
      latestMessage: entity.latestMessage,
      lastMessageTime: entity.lastMessageTime,
      text: entity.text,
      image: entity.image,
      audio: entity.audio,
      document: entity.document,
      documentName: entity.documentName,
      createdAt: entity.createdAt,
      email: entity.email, // Map email from entity
    );
  }

  // To Entity
  ChatEntity toEntity() {
    return ChatEntity(
      userId: userId,
      senderId: senderId,
      receiverId: receiverId,
      fullName: fullName,
      profilePic: profilePic ?? '',
      latestMessage: latestMessage,
      lastMessageTime: lastMessageTime,
      text: text,
      image: image,
      audio: audio,
      document: document,
      documentName: documentName,
      createdAt: createdAt,
      email: email ?? '', // Include email field in entity
    );
  }

  @override
  List<Object?> get props => [
        userId,
        senderId,
        receiverId,
        fullName,
        profilePic,
        latestMessage,
        lastMessageTime,
        text,
        image,
        audio,
        document,
        documentName,
        createdAt,
        email, // Include email in equality check
      ];
}
