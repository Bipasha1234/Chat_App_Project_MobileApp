import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:cool_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUserUseCase {
  final IAuthRepository _authRepository;

  GetCurrentUserUseCase(this._authRepository);

  Future<Either<Failure, AuthEntity>> call(String token) async {
    return await _authRepository.getCurrentUser(token);
  }
}
