import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_api_model.g.dart';

@JsonSerializable()
class ChatApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String userId;
  final String fullname;
  final String profilePic;
  final String latestMessage;
  final String messageTimestamp;

  const ChatApiModel({
    this.id,
    required this.userId,
    required this.fullname,
    required this.profilePic,
    this.latestMessage = "No message",
    this.messageTimestamp = "",
  });

  /// ✅ Convert API Model to Entity
  ChatEntity toEntity() {
    return ChatEntity(
      userId: userId,
      fullname: fullname,
      profilePic: profilePic,
      latestMessage: latestMessage,
      messageTimestamp: messageTimestamp,
    );
  }

  /// ✅ Create API Model from Entity
  factory ChatApiModel.fromEntity(ChatEntity entity) {
    return ChatApiModel(
      userId: entity.userId,
      fullname: entity.fullname,
      profilePic: entity.profilePic,
      latestMessage: entity.latestMessage,
      messageTimestamp: entity.messageTimestamp,
    );
  }

  /// ✅ Convert JSON to Model
  factory ChatApiModel.fromJson(Map<String, dynamic> json) =>
      _$ChatApiModelFromJson(json);

  /// ✅ Convert Model to JSON
  Map<String, dynamic> toJson() => _$ChatApiModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        fullname,
        profilePic,
        latestMessage,
        messageTimestamp,
      ];
}
