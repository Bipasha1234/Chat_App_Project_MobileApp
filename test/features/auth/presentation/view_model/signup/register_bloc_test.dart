import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:cool_app/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:cool_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

// class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockRegisterUseCase mockRegisterUseCase;
  late MockUploadImageUsecase mockUploadImageUsecase;
  late RegisterBloc registerBloc;

  // Register fallback value for RegisterUserParams and UploadImageParams
  setUpAll(() {
    registerFallbackValue(const RegisterUserParams(
      fullName: 'Bipasha Lamsal',
      email: 'bipashalamsal@gmail.com',
      password: '123456',
      profilePic: 'people_profile_pic.png',
    ));
    registerFallbackValue(UploadImageParams(
      file: File('dummy/path/to/file'),
    ));
  });

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    mockUploadImageUsecase = MockUploadImageUsecase();
    registerBloc = RegisterBloc(
      registerUseCase: mockRegisterUseCase,
      uploadImageUsecase: mockUploadImageUsecase,
    );
  });

  tearDown(() {
    registerBloc.close();
  });

  group('RegisterBloc', () {
    const String fullName = 'Bipasha Lamsal';
    const String email = 'bipashalamsal@gmail.com';
    const String password = '123456';
    const String imageName = 'people_profile_pic.png';
    const String errorMessage = 'Registration failed';

    blocTest<RegisterBloc, RegisterState>(
      'emits [isLoading: true, success state] when RegisterUser event succeeds',
      build: () {
        when(() => mockRegisterUseCase.call(any())).thenAnswer(
          (_) async => const Right('Registration successful'),
        );
        return registerBloc;
      },
      act: (bloc) => bloc.add(const RegisterUser(
        fullName: fullName,
        email: email,
        password: password,
      )),
      expect: () => [
        const RegisterState.initial().copyWith(isLoading: true),
        const RegisterState.initial()
            .copyWith(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockRegisterUseCase.call(any())).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [isLoading: true, failure state] when RegisterUser event fails',
      build: () {
        when(() => mockRegisterUseCase.call(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: errorMessage)),
        );
        return registerBloc;
      },
      act: (bloc) => bloc.add(const RegisterUser(
        fullName: fullName,
        email: email,
        password: password,
      )),
      expect: () => [
        const RegisterState.initial().copyWith(isLoading: true),
        const RegisterState.initial()
            .copyWith(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => mockRegisterUseCase.call(any())).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [isLoading: true, success state] when UploadImage event succeeds',
      build: () {
        when(() => mockUploadImageUsecase.call(any())).thenAnswer(
          (_) async => const Right(imageName),
        );
        return registerBloc;
      },
      act: (bloc) => bloc.add(UploadImage(file: File('path/to/file'))),
      expect: () => [
        const RegisterState.initial().copyWith(isLoading: true),
        const RegisterState.initial()
            .copyWith(isLoading: false, isSuccess: true, imageName: imageName),
      ],
      verify: (_) {
        verify(() => mockUploadImageUsecase.call(any())).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [isLoading: true, failure state] when UploadImage event fails',
      build: () {
        when(() => mockUploadImageUsecase.call(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Image upload failed')),
        );
        return registerBloc;
      },
      act: (bloc) => bloc.add(UploadImage(file: File('path/to/file'))),
      expect: () => [
        const RegisterState.initial().copyWith(isLoading: true),
        const RegisterState.initial()
            .copyWith(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => mockUploadImageUsecase.call(any())).called(1);
      },
    );
  });
}
