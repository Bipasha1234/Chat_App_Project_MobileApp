import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/use_case/send_message.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'repository_mock.dart';

void main() {
  late MockChatRepository chatRepository;
  late SendMessageUseCase usecase;

  setUp(() {
    chatRepository = MockChatRepository();
    usecase = SendMessageUseCase(chatRepository);
    registerFallbackValue(const ChatEntity(
      userId: '1',
      text: 'Test message',
      senderId: 'senderId',
      receiverId: 'receiverId',
      fullName: 'Full Name',
      profilePic: 'profilePicUrl',
    ));
  });

  const chatEntity = ChatEntity(
    userId: '1',
    text: 'Test message',
    senderId: 'senderId',
    receiverId: 'receiverId',
    fullName: 'Full Name',
    profilePic: 'profilePicUrl',
  );

  test('should call [ChatRepository.sendMessage] with correct params',
      () async {
    // Arrange
    when(() => chatRepository.sendMessage(any())).thenAnswer(
      (_) async => const Right(true),
    );

    // Act
    final result = await usecase(chatEntity);

    // Assert
    expect(result, const Right(true));

    // Verify
    verify(() => chatRepository.sendMessage(chatEntity)).called(1);
    verifyNoMoreInteractions(chatRepository);
  });
}
