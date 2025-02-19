// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatApiModel _$ChatApiModelFromJson(Map<String, dynamic> json) => ChatApiModel(
      userId: json['_id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      fullName: json['fullName'] as String,
      profilePic: json['profilePic'] as String?,
      latestMessage: json['latestMessage'] as String? ?? "No message",
      lastMessageTime: json['lastMessageTime'] == null
          ? null
          : DateTime.parse(json['lastMessageTime'] as String),
      text: json['text'] as String?,
      image: json['image'] as String?,
      audio: json['audio'] as String?,
      document: json['document'] as String?,
      documentName: json['documentName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ChatApiModelToJson(ChatApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'fullName': instance.fullName,
      'profilePic': instance.profilePic,
      'latestMessage': instance.latestMessage,
      'lastMessageTime': instance.lastMessageTime?.toIso8601String(),
      'text': instance.text,
      'image': instance.image,
      'audio': instance.audio,
      'document': instance.document,
      'documentName': instance.documentName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'email': instance.email,
    };
