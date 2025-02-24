import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/use_case/get_block_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'repository_mock.dart';

void main() {
  late MockChatRepository chatRepository;
  late GetBlockedUsersUseCase usecase;

  setUp(() {
    chatRepository = MockChatRepository();
    usecase = GetBlockedUsersUseCase(chatRepository);
  });

  test('should return a list of blocked users when successful', () async {
    // Arrange
    final List<ChatEntity> blockedUsers = [
      const ChatEntity(
        userId: 'user1',
        senderId: 'sender1',
        receiverId: 'receiver1',
        fullName: 'User 1',
        profilePic: 'profilePic1',
      ),
      const ChatEntity(
        userId: 'user2',
        senderId: 'sender2',
        receiverId: 'receiver2',
        fullName: 'User 2',
        profilePic: 'profilePic2',
      ),
    ];
    when(() => chatRepository.getBlockedUsers()).thenAnswer(
      (_) async => Right(blockedUsers),
    );

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(blockedUsers));

    // Verify
    verify(() => chatRepository.getBlockedUsers()).called(1);
    verifyNoMoreInteractions(chatRepository);
  });
}
