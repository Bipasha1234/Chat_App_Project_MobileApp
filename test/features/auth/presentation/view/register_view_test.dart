import 'package:cool_app/features/auth/presentation/view/register_view.dart';
import 'package:cool_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('RegisterView', () {
    late RegisterBloc mockRegisterBloc;

    setUp(() {
      mockRegisterBloc = MockRegisterBloc();
    });

    testWidgets('shows validation error when password is too short',
        (tester) async {
      // Build the RegisterView widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<RegisterBloc>(
            create: (_) => mockRegisterBloc,
            child: const RegisterView(),
          ),
        ),
      );

      // Enter valid email and full name, but a short password
      await tester.enterText(
          find.byKey(const ValueKey('email')), 'test@test.com');
      await tester.enterText(
          find.byKey(const ValueKey('fullName')), 'Test User');
      await tester.enterText(find.byKey(const ValueKey('password')), 'short');

      // Tap the Register button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the validation error message for password is displayed
      expect(find.text('Password must be at least 6 characters long'),
          findsOneWidget);
    });
  });
}

// Mock class for RegisterBloc
class MockRegisterBloc extends Mock implements RegisterBloc {}
