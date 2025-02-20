import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class IChatRepository {
  Future<Either<Failure, List<ChatEntity>>> getUsersForSidebar();

  // Add the sendMessage method
  Future<Either<Failure, bool>> sendMessage(ChatEntity chatEntity);

  Future<Either<Failure, List<ChatEntity>>> getMessages(
      String chatId, String? token);

  Future<Either<Failure, void>> deleteChat(String chatId, String? token);

  Future<Either<Failure, void>> blockUser(String chatId, String? token);
}
