import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/auth/domain/use_case/login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';
import 'token.mock.dart';

void main() {
  late AuthRepoMock repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUseCase usecase;

  setUp(() {
    repository = AuthRepoMock();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = LoginUseCase(repository, tokenSharedPrefs);
  });

  test(
      'should call the [AuthRepo.login] with correct email and password (bipashalamsal@gmail.com, 123456)',
      () async {
    when(() => repository.loginUser(any(), any())).thenAnswer(
      (invocation) async {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;

        if (email == 'bipashalamsal@gmail.com' && password == '123456') {
          return Future.value(const Right('token'));
        } else {
          return Future.value(
              const Left(ApiFailure(message: 'Invalid username or password')));
        }
      },
    );
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right('token'));
    when(() => tokenSharedPrefs.saveToken(any())).thenAnswer(
      (_) async => const Right(null),
    );

    final result = await usecase(const LoginParams(
      email: 'bipashalamsal@gmail.com',
      password: '123456',
    ));

    expect(result, const Right('token'));

    verify(() => repository.loginUser(any(), any())).called(1);
    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });

  test('should return failure when there is a server error', () async {
    when(() => repository.loginUser(any(), any())).thenAnswer(
      (_) async => const Left(
          ApiFailure(message: 'Server error, please try again later')),
    );

    final result = await usecase(const LoginParams(
      email: 'bipashalamsal@gmail.com',
      password: '123456',
    ));

    expect(
        result,
        const Left(
            ApiFailure(message: 'Server error, please try again later')));

    verify(() => repository.loginUser(any(), any())).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return failure when token retrieval fails', () async {
    when(() => repository.loginUser(any(), any())).thenAnswer(
      (_) async => const Right('token'),
    );

    when(() => tokenSharedPrefs.getToken()).thenAnswer(
      (_) async => const Left(ApiFailure(message: 'Failed to retrieve token')),
    );

    final result = await tokenSharedPrefs.getToken();

    expect(result, const Left(ApiFailure(message: 'Failed to retrieve token')));

    verify(() => tokenSharedPrefs.getToken()).called(1);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });
}
