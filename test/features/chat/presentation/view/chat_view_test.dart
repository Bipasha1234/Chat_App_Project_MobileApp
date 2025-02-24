import 'package:bloc_test/bloc_test.dart';
import 'package:cool_app/features/chat/presentation/view/chat_view.dart';
import 'package:cool_app/features/chat/presentation/view_model/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatBloc extends MockBloc<ChatEvent, ChatState> implements ChatBloc {}

void main() {
  late MockChatBloc chatBloc;

  setUp(() {
    chatBloc = MockChatBloc();
  });

  Widget createChatView() {
    return BlocProvider<ChatBloc>(
      create: (context) => chatBloc,
      child: const MaterialApp(home: ChatView()),
    );
  }

  testWidgets('shows "No users available" when users list is empty',
      (tester) async {
    when(() => chatBloc.state).thenReturn(const ChatState(
      isLoading: false,
      users: [],
      error: null,
      isSending: false,
      isLoadingMessages: false,
      sendMessageSuccess: false,
      messages: [],
      blockedUsers: [],
    ));

    await tester.pumpWidget(createChatView());
    await tester.pumpAndSettle();

    // Check if the "No users available" text is shown
    expect(find.text('No users available.'), findsOneWidget);
  });

  testWidgets('does not show loading indicator when not isLoading',
      (tester) async {
    when(() => chatBloc.state).thenReturn(
      const ChatState(
        isLoading: false,
        users: [],
        error: null,
        isSending: false,
        isLoadingMessages: false,
        sendMessageSuccess: false,
        messages: [],
        blockedUsers: [],
      ),
    );

    await tester.pumpWidget(createChatView());
    await tester.pumpAndSettle();

    // Verify that loading indicator is not shown
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
