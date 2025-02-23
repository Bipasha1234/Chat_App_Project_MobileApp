import 'package:bloc_test/bloc_test.dart';
import 'package:cool_app/features/auth/presentation/view/register_view.dart';
import 'package:cool_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterBloc extends MockBloc<RegisterEvent, RegisterState>
    implements RegisterBloc {}

void main() {
  late MockRegisterBloc registerBloc;

  setUp(() {
    registerBloc = MockRegisterBloc();
  });

  Widget loadRegisterView() {
    return BlocProvider<RegisterBloc>(
      create: (context) => registerBloc,
      child: const MaterialApp(home: RegisterView()),
    );
  }

  testWidgets('Check if "Register Account" text is displayed', (tester) async {
    await tester.pumpWidget(loadRegisterView());

    await tester.pumpAndSettle();

    final registerTextFinder = find.text('Register Account');

    expect(registerTextFinder, findsOneWidget);
  });

  testWidgets('shows validation error when password is too short',
      (tester) async {
    await tester.pumpWidget(loadRegisterView());
    await tester.pumpAndSettle();

    // Enter valid email and full name, but a short password
    await tester.enterText(
        find.byKey(const ValueKey('email')), 'test@test.com');
    await tester.enterText(find.byKey(const ValueKey('fullName')), 'Test User');
    await tester.enterText(find.byKey(const ValueKey('password')), 'short');

    // Tap the Register button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Check if the error message is shown for password
    expect(find.text('Password must be at least 6 characters long'),
        findsOneWidget);
  });

  testWidgets('Check for the validator error when no input is provided',
      (tester) async {
    await tester.pumpWidget(loadRegisterView());
    await tester.pumpAndSettle();

    // Tap the Register button without filling out the form
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    // Check for form validation error messages
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your full name'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Register success', (tester) async {
    when(() => registerBloc.state)
        .thenReturn(const RegisterState(isLoading: true, isSuccess: true));

    await tester.pumpWidget(loadRegisterView());
    await tester.pumpAndSettle();

    // Simulate entering valid data in the form fields
    await tester.enterText(
        find.byKey(const ValueKey('email')), 'bipashalamsal@gmail.com');
    await tester.enterText(
        find.byKey(const ValueKey('fullName')), 'Bipasha Lamsal');
    await tester.enterText(find.byKey(const ValueKey('password')), '123456');

    // Tap the Register button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Assert that the registration is successful
    expect(registerBloc.state.isSuccess, true);
  });
}
