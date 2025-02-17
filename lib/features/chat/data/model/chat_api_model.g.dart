// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatApiModel _$ChatApiModelFromJson(Map<String, dynamic> json) => ChatApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      fullname: json['fullname'] as String,
      profilePic: json['profilePic'] as String,
      latestMessage: json['latestMessage'] as String? ?? "No message",
      messageTimestamp: json['messageTimestamp'] as String? ?? "",
    );

Map<String, dynamic> _$ChatApiModelToJson(ChatApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'fullname': instance.fullname,
      'profilePic': instance.profilePic,
      'latestMessage': instance.latestMessage,
      'messageTimestamp': instance.messageTimestamp,
    };
