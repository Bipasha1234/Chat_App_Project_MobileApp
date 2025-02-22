import 'package:cool_app/features/chat/domain/use_case/unblock_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth/domain/use_case/token.mock.dart';
import 'repository_mock.dart';

void main() {
  late MockChatRepository chatRepository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late UnBlockUserUsecase usecase;

  setUp(() {
    chatRepository = MockChatRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = UnBlockUserUsecase(
      chatRepository: chatRepository,
      tokenSharedPrefs: tokenSharedPrefs,
    );
    registerFallbackValue(const UnBlockUserParams.empty());
  });

  const params = UnBlockUserParams(chatId: 'chat123');

  test(
      'should call [ChatRepository.unblockUser] with correct params when token is valid',
      () async {
    // Arrange
    when(() => tokenSharedPrefs.getToken()).thenAnswer(
      (_) async => const Right('valid_token'),
    );
    when(() => chatRepository.unblockUser(any(), any())).thenAnswer(
      (_) async => const Right(null),
    );

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right(null));

    // Verify
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => chatRepository.unblockUser('chat123', 'valid_token'))
        .called(1);
    verifyNoMoreInteractions(chatRepository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });
}
