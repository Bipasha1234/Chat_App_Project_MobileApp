import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/chat/data/data_source/chat_local_datasource.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatLocalRepository implements IChatRepository {
  final ChatLocalDataSource _chatLocalDatasource;

  ChatLocalRepository(this._chatLocalDatasource);

  @override
  Future<Either<Failure, List<ChatEntity>>> getUsersForSidebar() async {
    try {
      final usersWithMessages = await _chatLocalDatasource.getUsersForSidebar();
      return Right(usersWithMessages);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> sendMessage(ChatEntity chatEntity) async {
    try {
      final result = await _chatLocalDatasource.sendMessage(chatEntity);
      return Right(result);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatEntity>>> getMessages(
      String chatId, String? token) async {
    try {
      final messages = await _chatLocalDatasource.getMessages(chatId, token);
      return Right(messages);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChat(String chatId, String? token) async {
    try {
      await _chatLocalDatasource.deleteChat(chatId, token);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> blockUser(String chatId, String? token) async {
    try {
      await _chatLocalDatasource.blockUser(chatId, token);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unblockUser(
      String chatId, String? token) async {
    try {
      await _chatLocalDatasource.unblockUser(chatId, token);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatEntity>>> getBlockedUsers() async {
    try {
      final blockedUsers = await _chatLocalDatasource.getBlockedUsers();
      return Right(blockedUsers);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
