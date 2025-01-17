import 'package:cool_app/app/usecase/usecase.dart';
import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:cool_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String? image;

  const RegisterUserParams({
    required this.fullName,
    required this.email,
    required this.password,
    this.image,
  });

  // Initial Constructor
  const RegisterUserParams.initial()
      : fullName = '',
        email = '',
        password = '',
        image = null;

  @override
  List<Object?> get props => [fullName, email, password, image];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    // Convert RegisterUserParams to AuthEntity
    final authEntity = AuthEntity(
      fullName: params.fullName,
      email: params.email,
      password: params.password,
      image: params.image,
    );
    return repository.registerUser(authEntity);
  }
}
