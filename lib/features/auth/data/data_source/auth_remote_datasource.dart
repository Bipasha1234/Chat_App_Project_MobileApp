import 'dart:io';

import 'package:cool_app/app/constants/api_endpoints.dart';
import 'package:cool_app/features/auth/data/data_source/auth_data_source.dart';
import 'package:cool_app/features/auth/data/model/auth_api_model.dart';
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
        if (token != null) {
          // Optionally, save the token securely
          return token;
        } else {
          throw Exception('Token not found in response');
        }
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
  Future<AuthEntity> getCurrentUser(String token) async {
    try {
      var response = await _dio.get(
        ApiEndpoints.getCurrentUser,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return AuthApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];

        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
