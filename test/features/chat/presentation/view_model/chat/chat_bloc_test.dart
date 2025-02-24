import 'package:bloc_test/bloc_test.dart';
import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/chat/domain/entity/chat_entity.dart';
import 'package:cool_app/features/chat/domain/use_case/block_user.dart';
import 'package:cool_app/features/chat/domain/use_case/delete_chat.dart';
import 'package:cool_app/features/chat/domain/use_case/get_block_users.dart';
import 'package:cool_app/features/chat/domain/use_case/get_messages.dart';
import 'package:cool_app/features/chat/domain/use_case/get_user_sidebar.dart';
import 'package:cool_app/features/chat/domain/use_case/send_message.dart';
import 'package:cool_app/features/chat/domain/use_case/unblock_user.dart';
import 'package:cool_app/features/chat/presentation/view_model/chat/chat_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock Use Cases
class MockGetUsersForSidebarUseCase extends Mock
    implements GetUsersForSidebarUseCase {}

class MockSendMessageUseCase extends Mock implements SendMessageUseCase {}

class MockGetMessagesUseCase extends Mock implements GetMessagesUseCase {}

class MockDeleteChatUsecase extends Mock implements DeleteChatUsecase {}

class MockBlockUserUsecase extends Mock implements BlockUserUsecase {}

class MockUnBlockUserUsecase extends Mock implements UnBlockUserUsecase {}

class MockGetBlockedUsersUseCase extends Mock
    implements GetBlockedUsersUseCase {}

void main() {
  late MockGetUsersForSidebarUseCase mockGetUsersForSidebarUseCase;
  late MockSendMessageUseCase mockSendMessageUseCase;
  late MockGetMessagesUseCase mockGetMessagesUseCase;
  late MockDeleteChatUsecase mockDeleteChatUsecase;
  late MockBlockUserUsecase mockBlockUserUsecase;
  late MockUnBlockUserUsecase mockUnBlockUserUsecase;
  late MockGetBlockedUsersUseCase mockGetBlockedUsersUseCase;
  late ChatBloc chatBloc;

  setUp(() {
    mockGetUsersForSidebarUseCase = MockGetUsersForSidebarUseCase();
    mockSendMessageUseCase = MockSendMessageUseCase();
    mockGetMessagesUseCase = MockGetMessagesUseCase();
    mockDeleteChatUsecase = MockDeleteChatUsecase();
    mockBlockUserUsecase = MockBlockUserUsecase();
    mockUnBlockUserUsecase = MockUnBlockUserUsecase();
    mockGetBlockedUsersUseCase = MockGetBlockedUsersUseCase();

    chatBloc = ChatBloc(
      getUsersForSidebarUseCase: mockGetUsersForSidebarUseCase,
      sendMessageUseCase: mockSendMessageUseCase,
      getMessagesUseCase: mockGetMessagesUseCase,
      deleteChatUsecase: mockDeleteChatUsecase,
      blockUserUsecase: mockBlockUserUsecase,
      unblockUserUsecase: mockUnBlockUserUsecase,
      getblockedUserUsecase: mockGetBlockedUsersUseCase,
    );
  });

  group('ChatBloc', () {
    const chatEntity = ChatEntity(
      text: 'Hello',
      senderId: 'user1',
      userId: 'user1',
      receiverId: 'user2',
      fullName: 'User One',
      profilePic: 'path/to/profilePic',
    );

    final users = [
      const ChatEntity(
        text: 'Hello',
        senderId: 'user1',
        userId: 'user1',
        receiverId: 'user2',
        fullName: 'User One',
        profilePic: 'path/to/profilePic',
      ),
      const ChatEntity(
        text: 'Hi',
        senderId: 'user2',
        userId: 'user2',
        receiverId: 'user1',
        fullName: 'User Two',
        profilePic: 'path/to/profilePic2',
      ),
    ];

    const errorMessage = 'Failed to load users';

    final blockedUsers = [
      const ChatEntity(
        text: '',
        senderId: '',
        userId: 'user3',
        receiverId: '',
        fullName: '',
        profilePic: '',
      ),
      const ChatEntity(
        text: '',
        senderId: '',
        userId: 'user4',
        receiverId: '',
        fullName: '',
        profilePic: '',
      ),
    ];

    blocTest<ChatBloc, ChatState>(
      'emits [isLoading: true, users loaded successfully] when LoadGetUser event is added',
      build: () {
        when(() => mockGetUsersForSidebarUseCase.call())
            .thenAnswer((_) async => Right(users));
        return chatBloc;
      },
      act: (bloc) => bloc.add(LoadGetUser()),
      expect: () => [
        ChatState.initial().copyWith(isLoading: true),
        ChatState.initial()
            .copyWith(isLoading: false, users: users, error: null),
      ],
      verify: (_) {
        verify(() => mockGetUsersForSidebarUseCase.call()).called(1);
      },
    );

    blocTest<ChatBloc, ChatState>(
      'emits error state when LoadGetUser event fails',
      build: () {
        when(() => mockGetUsersForSidebarUseCase.call()).thenAnswer(
            (_) async => const Left(ApiFailure(message: errorMessage)));
        return chatBloc;
      },
      act: (bloc) => bloc.add(LoadGetUser()),
      expect: () => [
        ChatState.initial().copyWith(isLoading: true),
        ChatState.initial().copyWith(
            isLoading: false,
            error: 'Failed to load users: Failed to load users'),
      ],
      verify: (_) {
        verify(() => mockGetUsersForSidebarUseCase.call()).called(1);
      },
    );

    blocTest<ChatBloc, ChatState>(
      'emits error state when SendMessage event fails',
      build: () {
        when(() => mockSendMessageUseCase.call(chatEntity)).thenAnswer(
            (_) async =>
                const Left(ApiFailure(message: 'Failed to send message')));
        return chatBloc;
      },
      act: (bloc) => bloc.add(SendMessage(chatEntity)),
      expect: () => [
        ChatState.initial().copyWith(isSending: true),
        ChatState.initial().copyWith(
            isSending: false,
            error: 'Failed to send message: Failed to send message'),
      ],
      verify: (_) {
        verify(() => mockSendMessageUseCase.call(chatEntity)).called(1);
      },
    );

    blocTest<ChatBloc, ChatState>(
      'emits [isLoading: true, blocked users loaded successfully] when LoadBlockedUsers event is added',
      build: () {
        when(() => mockGetBlockedUsersUseCase.call())
            .thenAnswer((_) async => Right(blockedUsers));
        return chatBloc;
      },
      act: (bloc) => bloc.add(LoadBlockedUsers()),
      expect: () => [
        ChatState.initial().copyWith(isLoading: true),
        ChatState.initial().copyWith(
            isLoading: false, blockedUsers: blockedUsers, error: null),
      ],
      verify: (_) {
        verify(() => mockGetBlockedUsersUseCase.call()).called(1);
      },
    );

    blocTest<ChatBloc, ChatState>(
      'emits error state when LoadBlockedUsers event fails',
      build: () {
        when(() => mockGetBlockedUsersUseCase.call()).thenAnswer((_) async =>
            const Left(ApiFailure(message: 'Failed to load blocked users')));
        return chatBloc;
      },
      act: (bloc) => bloc.add(LoadBlockedUsers()),
      expect: () => [
        ChatState.initial().copyWith(isLoading: true),
        ChatState.initial().copyWith(
            isLoading: false,
            error:
                'Failed to load blocked users: Failed to load blocked users'),
      ],
      verify: (_) {
        verify(() => mockGetBlockedUsersUseCase.call()).called(1);
      },
    );
  });

  tearDown(() {
    chatBloc.close();
  });
}
