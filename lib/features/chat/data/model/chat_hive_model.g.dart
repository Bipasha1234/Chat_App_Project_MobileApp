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
      senderId: fields[1] as String,
      receiverId: fields[2] as String,
      fullName: fields[3] as String,
      profilePic: fields[4] as String?,
      latestMessage: fields[5] as String,
      lastMessageTime: fields[6] as DateTime?,
      text: fields[7] as String?,
      image: fields[8] as String?,
      audio: fields[9] as String?,
      document: fields[10] as String?,
      documentName: fields[11] as String?,
      createdAt: fields[12] as DateTime?,
      email: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatHiveModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.senderId)
      ..writeByte(2)
      ..write(obj.receiverId)
      ..writeByte(3)
      ..write(obj.fullName)
      ..writeByte(4)
      ..write(obj.profilePic)
      ..writeByte(5)
      ..write(obj.latestMessage)
      ..writeByte(6)
      ..write(obj.lastMessageTime)
      ..writeByte(7)
      ..write(obj.text)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.audio)
      ..writeByte(10)
      ..write(obj.document)
      ..writeByte(11)
      ..write(obj.documentName)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.email);
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
