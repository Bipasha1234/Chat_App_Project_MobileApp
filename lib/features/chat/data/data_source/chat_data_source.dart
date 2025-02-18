import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';

abstract interface class IChatDataSource {
  // Existing method to fetch users for the sidebar
  Future<List<ChatEntity>> getUsersForSidebar();

  // New method to send a message
  Future<bool> sendMessage(ChatEntity chatEntity);
}
