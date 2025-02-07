import 'dart:io';

import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String email, String password);

  Future<void> registerUser(AuthEntity user);

  Future<AuthEntity> getCurrentUser(String token);

  Future<String> uploadProfilePicture(File file);
}
