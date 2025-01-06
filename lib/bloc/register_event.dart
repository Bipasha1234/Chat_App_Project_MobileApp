import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class UpdateEmail extends RegisterEvent {
  final String email;

  const UpdateEmail(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdatePassword extends RegisterEvent {
  final String password;

  const UpdatePassword(this.password);

  @override
  List<Object?> get props => [password];
}

class UpdateConfirmPassword extends RegisterEvent {
  final String confirmPassword;

  const UpdateConfirmPassword(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class SubmitRegistration extends RegisterEvent {}
