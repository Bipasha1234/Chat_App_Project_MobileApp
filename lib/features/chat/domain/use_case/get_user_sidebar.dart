import 'package:cool_app/app/usecase/usecase.dart';
import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class GetUsersForSidebarUseCase
    implements UsecaseWithoutParams<List<ChatEntity>> {
  final IChatRepository _chatRepository;

  GetUsersForSidebarUseCase(this._chatRepository);

  @override
  Future<Either<Failure, List<ChatEntity>>> call() {
    return _chatRepository.getUsersForSidebar();
  }
}
