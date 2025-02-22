import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:cool_app/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late RegisterUseCase useCase;
  late AuthRepoMock mockRepository;

  setUpAll(() {
    registerFallbackValue(const AuthEntity(
      email: 'bipashalamsal@gmail.com',
      fullName: 'bipasha',
      password: '123456',
      profilePic: null,
    ));
  });

  setUp(() {
    mockRepository = AuthRepoMock();
    useCase = RegisterUseCase(mockRepository);
  });

  group('Register UseCase Tests', () {
    test('should return success when registration is successful', () async {
      when(() => mockRepository.registerUser(any()))
          .thenAnswer((invocation) async {
        final authEntity = invocation.positionalArguments[0] as AuthEntity;
        if (authEntity.email == 'bipashalamsal@gmail.com' &&
            authEntity.fullName == 'bipasha' &&
            authEntity.password == '123456') {
          return const Right(null);
        } else {
          return const Left(
              ApiFailure(message: 'Invalid registration details'));
        }
      });

      const params = RegisterUserParams(
        email: 'bipashalamsal@gmail.com',
        fullName: 'bipasha',
        password: '123456',
      );

      final result = await useCase(params);
      expect(result, const Right(null));

      verify(() => mockRepository.registerUser(any())).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when registration fields are null', () async {
      when(() => mockRepository.registerUser(any()))
          .thenAnswer((invocation) async {
        final authEntity = invocation.positionalArguments[0] as AuthEntity;
        if (authEntity.email == '' ||
            authEntity.password == '' ||
            authEntity.fullName == '') {
          return const Left(ApiFailure(message: 'Fields cannot be null'));
        } else {
          return const Right(null);
        }
      });

      const params = RegisterUserParams(
        email: '',
        fullName: '',
        password: '',
      );

      final result = await useCase(params);
      expect(result, const Left(ApiFailure(message: 'Fields cannot be null')));

      verify(() => mockRepository.registerUser(any())).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
