import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/use_case/get_messages.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth/domain/use_case/token.mock.dart';
import 'repository_mock.dart';

void main() {
  late MockChatRepository chatRepository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late GetMessagesUseCase usecase;

  setUp(() {
    chatRepository = MockChatRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = GetMessagesUseCase(
      chatRepository: chatRepository,
      tokenSharedPrefs: tokenSharedPrefs,
    );
    registerFallbackValue(const GetMessagesParams.empty());
  });

  const chatId = 'chat123';
  const params = GetMessagesParams(chatId: chatId);

  test(
      'should call [ChatRepository.getMessages] with correct params when token is valid',
      () async {
    // Arrange
    final chatEntities = [
      const ChatEntity(
        text: 'Hello!',
        userId: 'user1',
        senderId: 'sender1',
        receiverId: 'receiver1',
        fullName: 'John Doe',
        profilePic: 'profilePic1',
      ),
      const ChatEntity(
        text: 'How are you?',
        userId: 'user2',
        senderId: 'sender2',
        receiverId: 'receiver2',
        fullName: 'Jane Doe',
        profilePic: 'profilePic2',
      ),
    ];

    when(() => tokenSharedPrefs.getToken()).thenAnswer(
      (_) async => const Right('valid_token'),
    );
    when(() => chatRepository.getMessages(chatId, 'valid_token')).thenAnswer(
      (_) async => Right(chatEntities),
    );

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Right(chatEntities));

    // Verify
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => chatRepository.getMessages(chatId, 'valid_token')).called(1);
    verifyNoMoreInteractions(chatRepository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });
}
