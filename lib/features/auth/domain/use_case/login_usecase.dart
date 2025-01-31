import 'package:cool_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:cool_app/app/usecase/usecase.dart';
import 'package:cool_app/core/error/failure.dart';
import 'package:cool_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : email = '',
        password = '';

  @override
  List<Object> get props => [email, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase(this.repository, TokenSharedPrefs tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    // IF api then store token in shared preferences
    return repository.loginUser(params.email, params.password);
  }
}
