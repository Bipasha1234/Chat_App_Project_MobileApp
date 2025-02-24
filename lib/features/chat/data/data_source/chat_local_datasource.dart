import 'package:cool_app/core/network/hive_service.dart';
import 'package:cool_app/features/chat/data/data_source/chat_data_source.dart';
import 'package:cool_app/features/chat/data/model/chat_hive_model.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';

class ChatLocalDataSource implements IChatDataSource {
  final HiveService _hiveService;

  ChatLocalDataSource(this._hiveService);

  @override
  Future<List<ChatEntity>> getUsersForSidebar() async {
    try {
      final users = await _hiveService.getChatUsers();
      return users.map((e) => e.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<bool> sendMessage(ChatEntity chatEntity) async {
    try {
      final chatHiveModel = ChatHiveModel.fromEntity(chatEntity);

      await _hiveService.saveChatMessage(chatHiveModel);
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<ChatEntity>> getMessages(String chatId, String? token) async {
    try {
      final messages = await _hiveService.getChatMessages(chatId);

      return messages.map((e) => e.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> deleteChat(String chatId, String? token) async {
    try {
      await _hiveService.deleteChat(chatId);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> blockUser(String chatId, String? token) async {
    try {
      await _hiveService.blockUser(chatId);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> unblockUser(String chatId, String? token) async {
    try {
      await _hiveService.unblockUser(chatId);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<ChatEntity>> getBlockedUsers() async {
    try {
      final blockedUsers = await _hiveService.getBlockedUsers();

      return blockedUsers.map((e) => e.toEntity()).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}
