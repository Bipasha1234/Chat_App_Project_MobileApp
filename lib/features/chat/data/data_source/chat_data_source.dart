import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';

abstract interface class IChatDataSource {
  Future<List<ChatEntity>> getUsersForSidebar();

  Future<bool> sendMessage(ChatEntity chatEntity);

  Future<List<ChatEntity>> getMessages(String chatId, String? token);

  Future<void> deleteChat(String chatId, String? token);

  Future<void> blockUser(String chatId, String? token);

  Future<void> unblockUser(String chatId, String? token);

  Future<List<ChatEntity>> getBlockedUsers();
}
