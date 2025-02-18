import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class SendMessageUseCase {
  final IChatRepository _chatRepository;

  SendMessageUseCase(this._chatRepository);

  Future<Either<Failure, bool>> call(ChatEntity chatEntity) async {
    // Call the repository's sendMessage method
    return await _chatRepository.sendMessage(chatEntity);
  }
}
