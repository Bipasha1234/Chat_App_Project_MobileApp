import 'package:bloc_test/bloc_test.dart';
import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:cool_app/features/auth/domain/use_case/get_current_user_usecase.dart';
import 'package:cool_app/features/auth/domain/use_case/login_usecase.dart';
import 'package:cool_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:cool_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:cool_app/features/home/presentation/view_model/home_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockRegisterBloc extends Mock implements RegisterBloc {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

void main() {
  late LoginBloc loginBloc;
  late MockRegisterBloc mockRegisterBloc;
  late MockHomeCubit mockHomeCubit;
  late MockLoginUseCase mockLoginUseCase;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    mockHomeCubit = MockHomeCubit();
    mockLoginUseCase = MockLoginUseCase();
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();

    loginBloc = LoginBloc(
      registerBloc: mockRegisterBloc,
      homeCubit: mockHomeCubit,
      loginUseCase: mockLoginUseCase,
      getCurrentUserUseCase: mockGetCurrentUserUseCase,
    );

    registerFallbackValue(
        const LoginParams(email: 'bipashalamsal@mail.com', password: '123456'));
    registerFallbackValue(const AuthEntity(
        email: 'bipashalamsal@mail.com',
        fullName: 'Bipasha Lamsal',
        password: '123456'));
  });

  tearDown(() {
    loginBloc.close();
  });

  test('Initial state should be LoginState.initial()', () {
    expect(loginBloc.state, LoginState.initial());
  });

  blocTest<LoginBloc, LoginState>(
    'emits [loading, user fetched] when fetching user details succeeds',
    build: () {
      when(() => mockGetCurrentUserUseCase(any())).thenAnswer(
        (_) async => const Right(AuthEntity(
          email: 'bipashalamsal@gmail.com',
          fullName: 'Bipasha Lamsal',
          password: '123456',
        )),
      );
      return loginBloc;
    },
    act: (bloc) => bloc.add(FetchCurrentUserEvent(
      token: 'mock_token',
      context: MockBuildContext(),
    )),
    expect: () => [
      LoginState.initial().copyWith(isLoading: true),
      LoginState.initial().copyWith(
        isLoading: false,
        isSuccess: true,
        user: const AuthEntity(
            email: 'bipashalamsal@gmail.com',
            fullName: 'Bipasha Lamsal',
            password: '123456'),
      ),
    ],
    verify: (_) {
      verify(() => mockGetCurrentUserUseCase(any())).called(1);
    },
  );
}

/// Mocks Flutter BuildContext for Navigator
class MockBuildContext extends Mock implements BuildContext {}
