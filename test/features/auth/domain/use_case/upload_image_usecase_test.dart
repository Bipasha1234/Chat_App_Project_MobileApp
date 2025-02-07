import 'dart:io';

import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late UploadImageUsecase useCase;
  late AuthRepoMock mockRepository;

  setUp(() {
    mockRepository = AuthRepoMock();
    useCase = UploadImageUsecase(mockRepository);
  });

  group('Upload Image Usecase Tests', () {
    test('should return success when image upload is successful', () async {
      final file = File('assets/images/check.png');
      when(() => mockRepository.uploadProfilePicture(file))
          .thenAnswer((invocation) async {
        final uploadedFile = invocation.positionalArguments[0] as File;
        if (uploadedFile.path.isNotEmpty) {
          return const Right('Image uploaded successfully');
        } else {
          return const Left(ApiFailure(message: 'Failed to upload image'));
        }
      });

      final params = UploadImageParams(file: file);

      final result = await useCase(params);

      expect(result, const Right('Image uploaded successfully'));

      verify(() => mockRepository.uploadProfilePicture(file)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when image upload fails', () async {
      final file = File(''); // Passing an empty path to simulate failure
      when(() => mockRepository.uploadProfilePicture(file))
          .thenAnswer((invocation) async {
        return const Left(ApiFailure(message: 'Failed to upload image'));
      });

      final params = UploadImageParams(file: file);

      final result = await useCase(params);
      expect(result, const Left(ApiFailure(message: 'Failed to upload image')));

      verify(() => mockRepository.uploadProfilePicture(file)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
