import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_api_model.g.dart';

@JsonSerializable()
class ChatApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String userId;
  final String senderId; // Added senderId
  final String receiverId; // Added receiverId
  final String fullName;
  final String? profilePic;
  final String latestMessage;
  final DateTime? lastMessageTime;

  // Added message content fields
  final String? text; // Text content of the message
  final String? image; // Image URL if an image is sent
  final String? audio; // Audio URL if an audio file is sent
  final String? document; // Document URL if a document is sent
  final String? documentName; // Document name if a document is sent

  const ChatApiModel({
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

  /// ✅ Convert API Model to Entity
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

  /// ✅ Create API Model from Entity
  factory ChatApiModel.fromEntity(ChatEntity entity) {
    return ChatApiModel(
      userId: entity.userId,
      senderId: entity.senderId, // Mapping senderId from entity
      receiverId: entity.receiverId, // Mapping receiverId from entity
      fullName: entity.fullName,
      profilePic: entity.profilePic,
      latestMessage: entity.latestMessage,
      lastMessageTime: entity.lastMessageTime,
      text: entity.text,
      image: entity.image,
      audio: entity.audio,
      document: entity.document,
      documentName: entity.documentName,
    );
  }

  /// ✅ Convert JSON to Model
  factory ChatApiModel.fromJson(Map<String, dynamic> json) {
    return ChatApiModel(
      userId: json['_id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      fullName: json['fullName'] as String,
      profilePic: json['profilePic'] as String?,
      latestMessage: json['latestMessage'] as String? ?? "No message",
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.parse(json['lastMessageTime'])
          : null,
      text: json['text'] as String?,
      image: json['image'] as String?,
      audio: json['audio'] as String?,
      document: json['document'] as String?,
      documentName: json['documentName'] as String?,
    );
  }

  /// ✅ Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': userId,
      'senderId': senderId,
      'receiverId': receiverId,
      'fullName': fullName,
      'profilePic': profilePic,
      'latestMessage': latestMessage,
      'lastMessageTime': lastMessageTime?.toIso8601String(),
      'text': text,
      'image': image,
      'audio': audio,
      'document': document,
      'documentName': documentName,
    };
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
