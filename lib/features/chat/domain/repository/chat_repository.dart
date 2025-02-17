import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class IChatRepository {
  Future<Either<Failure, List<ChatEntity>>> getUsersForSidebar();
}
