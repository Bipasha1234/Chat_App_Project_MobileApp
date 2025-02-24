import 'package:cool_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:cool_app/app/usecase/usecase.dart';
import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/chat/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class BlockUserParams extends Equatable {
  final String chatId;

  const BlockUserParams({required this.chatId});

  const BlockUserParams.empty() : chatId = '_empty.string';

  @override
  List<Object?> get props => [
        chatId,
      ];
}

class BlockUserUsecase implements UsecaseWithParams<void, BlockUserParams> {
  final IChatRepository chatRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  BlockUserUsecase({
    required this.chatRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(BlockUserParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await chatRepository.blockUser(params.chatId, r);
    });
  }
}
