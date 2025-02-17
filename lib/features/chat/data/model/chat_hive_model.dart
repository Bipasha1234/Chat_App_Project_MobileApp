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
  final String fullname;
  @HiveField(2)
  final String profilePic;
  @HiveField(3)
  final String latestMessage;
  @HiveField(4)
  final String messageTimestamp;

  const ChatHiveModel({
    required this.userId,
    required this.fullname,
    required this.profilePic,
    this.latestMessage = "No message",
    this.messageTimestamp = "",
  });

  // Initial Constructor
  const ChatHiveModel.initial()
      : userId = '',
        fullname = '',
        profilePic = '',
        latestMessage = "No message",
        messageTimestamp = "";

  // From Entity
  factory ChatHiveModel.fromEntity(ChatEntity entity) {
    return ChatHiveModel(
      userId: entity.userId,
      fullname: entity.fullname,
      profilePic: entity.profilePic,
      latestMessage: entity.latestMessage,
      messageTimestamp: entity.messageTimestamp,
    );
  }

  // To Entity
  ChatEntity toEntity() {
    return ChatEntity(
      userId: userId,
      fullname: fullname,
      profilePic: profilePic,
      latestMessage: latestMessage,
      messageTimestamp: messageTimestamp,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        fullname,
        profilePic,
        latestMessage,
        messageTimestamp,
      ];
}
