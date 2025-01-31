import 'package:cool_app/app/usecase/usecase.dart';
import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:cool_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String email;
  final String fullName;
  final String password;
  final String? profilePic;

  const RegisterUserParams({
    required this.email,
    required this.fullName,
    required this.password,
    this.profilePic,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.email,
    required this.fullName,
    required this.password,
    this.profilePic,
  });

  @override
  List<Object?> get props => [email, fullName, password, profilePic];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    // Convert RegisterUserParams to AuthEntity
    final authEntity = AuthEntity(
      email: params.email,
      fullName: params.fullName,
      password: params.password,
      profilePic: params.profilePic,
    );
    return repository.registerUser(authEntity);
  }
}
