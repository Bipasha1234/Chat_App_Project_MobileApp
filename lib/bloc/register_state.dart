import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const RegisterState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}
