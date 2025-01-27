import 'dart:io';

import 'package:cool_app/app/constants/api_endpoints.dart';
import 'package:cool_app/features/auth/data/data_source/auth_data_source.dart';
import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:dio/dio.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDatasource(this._dio);

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        return token;
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Dio error occurred: ${e.message}');
      }
      throw Exception('An error occurred during login: $e');
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "email": user.email,
          "fullName": user.fullName,
          "password": user.password,
          "profilePic": user.profilePic,
        },
      );

      if (response.statusCode == 201) {
        return; // Registration successful
      } else {
        throw Exception(
            'Failed to register user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Dio error occurred: ${e.message}');
      }
      throw Exception('An error occurred during registration: $e');
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  // @override
  // Future<String> uploadProfilePicture(File file) async {
  //   try {
  //     String fileName = file.path.split('/').last;
  //     FormData formData = FormData.fromMap({
  //       "file": await MultipartFile.fromFile(file.path, filename: fileName),
  //     });

  //     Response response = await _dio.post(
  //       ApiEndpoints.uploadprofilePic,
  //       data: formData,
  //     );

  //     if (response.statusCode == 200) {
  //       final profilePicUrl = response.data['profilePicUrl'];
  //       return profilePicUrl;
  //     } else {
  //       throw Exception(
  //           'Failed to upload profile picture. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       throw Exception('Dio error occurred: ${e.message}');
  //     }
  //     throw Exception('An error occurred while uploading profile picture: $e');
  //   }
  // }
}
