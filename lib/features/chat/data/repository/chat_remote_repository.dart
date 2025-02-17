import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/chat/data/data_source/chat_remote_datasource.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatRemoteRepository implements IChatRepository {
  final ChatRemoteDataSource _chatRemoteDatasource;

  ChatRemoteRepository(this._chatRemoteDatasource);

  @override
  Future<Either<Failure, List<ChatEntity>>> getUsersForSidebar() async {
    try {
      final usersWithMessages =
          await _chatRemoteDatasource.getUsersForSidebar();
      return Right(usersWithMessages);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
