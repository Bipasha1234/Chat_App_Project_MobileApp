import 'package:bloc_test/bloc_test.dart';
import 'package:cool_app/features/auth/presentation/view/login_view.dart';
import 'package:cool_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late MockLoginBloc loginBloc;

  setUp(() {
    loginBloc = MockLoginBloc();
  });

  Widget loadLoginView() {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: const MaterialApp(home: LoginView()),
    );
  }

  // Test to check if the "Login Account" text is displayed
  testWidgets('Check if "Login Account" text is displayed', (tester) async {
    await tester.pumpWidget(loadLoginView());

    await tester.pumpAndSettle();

    // Find the "Login Account" text widget
    final loginTextFinder = find.text('Login Account');

    // Assert that the "Login Account" text widget is found
    expect(loginTextFinder, findsOneWidget);
  });

  testWidgets('Check for the username and password input', (tester) async {
    await tester.pumpWidget(loadLoginView());

    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(TextField).at(0), 'bipashalamsal@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), '123456');

    await tester.tap(find.byType(ElevatedButton).first);

    await tester.pumpAndSettle();

    expect(find.text('bipashalamsal@gmail.com'), findsOneWidget);
    expect(find.text('123456'), findsOneWidget);
  });

  testWidgets('Check for the validator error', (tester) async {
    await tester.pumpWidget(loadLoginView());

    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton).first);

    await tester.pumpAndSettle();

    expect(find.text('Please enter email'), findsOneWidget);
    expect(find.text('Please enter password'), findsOneWidget);
  });

  // Should show progress indicator when loading
  testWidgets('Login success', (tester) async {
    when(() => loginBloc.state)
        .thenReturn(const LoginState(isLoading: true, isSuccess: true));

    await tester.pumpWidget(loadLoginView());

    await tester.pumpAndSettle();
    await tester.enterText(
        find.byType(TextField).at(0), 'bipashalamsal@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), '123456');

    await tester.tap(find.byType(ElevatedButton).first);

    await tester.pumpAndSettle();

    expect(loginBloc.state.isSuccess, true);
  });
}
