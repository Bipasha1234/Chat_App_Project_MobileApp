import 'package:cool_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:cool_app/app/usecase/usecase.dart';
import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetMessagesParams extends Equatable {
  final String chatId;

  const GetMessagesParams({required this.chatId});

  const GetMessagesParams.empty() : chatId = '_empty.string';

  @override
  List<Object?> get props => [chatId];
}

class GetMessagesUseCase
    implements UsecaseWithParams<List<ChatEntity>, GetMessagesParams> {
  final IChatRepository chatRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetMessagesUseCase({
    required this.chatRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, List<ChatEntity>>> call(
      GetMessagesParams params) async {
    // Get token from Shared Preferences
    final token = await tokenSharedPrefs.getToken();
    return token.fold(
      (failure) => Left(failure),
      (tokenValue) async =>
          await chatRepository.getMessages(params.chatId, tokenValue),
    );
  }
}
