part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String email;
  final String fullName;
  final String password;

  const RegisterUser({
    required this.context,
    required this.email,
    required this.fullName,
    required this.password,
  });
}
