import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';

abstract interface class IChatDataSource {
  // Existing method to fetch users for the sidebar
  Future<List<ChatEntity>> getUsersForSidebar();

  // Method to send a message
  Future<bool> sendMessage(ChatEntity chatEntity);

  // New method to get messages for a specific chat (e.g., by chat ID or user ID)
  Future<List<ChatEntity>> getMessages(String chatId, String? token);

  Future<void> deleteChat(String chatId, String? token);

  Future<void> blockUser(String chatId, String? token);
}
