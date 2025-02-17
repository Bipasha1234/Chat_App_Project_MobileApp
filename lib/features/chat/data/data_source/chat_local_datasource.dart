// import 'dart:io';

// import 'package:cool_app/core/network/hive_service.dart';
// import 'package:cool_app/features/chat/data/data_source/chat_data_source.dart';
// import 'package:cool_app/features/chat/data/model/chat_hive_model.dart';
// import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';

// class ChatLocalDatasource implements IChatDataSource {
//   final HiveService _hiveService;

//   ChatLocalDatasource(this._hiveService);

//   @override
//   Future<void> sendMessage(ChatEntity message) async {
//     try {
//       // Convert ChatEntity to ChatHiveModel
//       final chatHiveModel = ChatHiveModel.fromEntity(message);

//       // Save the message in Hive
//       await _hiveService.saveChatMessage(chatHiveModel);
//       return Future.value();
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   @override
//   Future<List<ChatEntity>> getMessages(
//       String senderId, String receiverId) async {
//     try {
//       final messages = await _hiveService.getChatMessages(senderId, receiverId);

//       // Convert ChatHiveModels to ChatEntities
//       return messages.map((e) => e.toEntity()).toList();
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   @override
//   Future<List<String>> getChatUsers(String userId) async {
//     try {
//       final chatUsers = await _hiveService.getChatUsers(userId);

//       return chatUsers;
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   @override
//   Future<String> uploadChatMedia(File file) async {
//     throw UnimplementedError();
//   }
// }
