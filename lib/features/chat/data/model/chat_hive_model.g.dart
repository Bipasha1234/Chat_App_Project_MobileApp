// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatHiveModelAdapter extends TypeAdapter<ChatHiveModel> {
  @override
  final int typeId = 1;

  @override
  ChatHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatHiveModel(
      userId: fields[0] as String,
      fullname: fields[1] as String,
      profilePic: fields[2] as String,
      latestMessage: fields[3] as String,
      messageTimestamp: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.fullname)
      ..writeByte(2)
      ..write(obj.profilePic)
      ..writeByte(3)
      ..write(obj.latestMessage)
      ..writeByte(4)
      ..write(obj.messageTimestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
