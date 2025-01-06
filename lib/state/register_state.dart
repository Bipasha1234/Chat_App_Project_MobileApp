import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String? errorMessage;
  final bool isSubmitting;
  final bool isSuccess;

  const RegisterState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.errorMessage,
    this.isSubmitting = false,
    this.isSuccess = false,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? errorMessage,
    bool? isSubmitting,
    bool? isSuccess,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, confirmPassword, errorMessage, isSubmitting, isSuccess];
}
