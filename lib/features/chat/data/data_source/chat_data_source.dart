import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';

abstract interface class IChatDataSource {
  Future<List<ChatEntity>> getUsersForSidebar();
}
