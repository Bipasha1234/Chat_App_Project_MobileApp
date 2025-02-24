// login_state.dart

part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? token;
  final AuthEntity? user;

  const LoginState({
    required this.isLoading,
    required this.isSuccess,
    this.token,
    this.user,
  });

  factory LoginState.initial() {
    return const LoginState(
      isLoading: false,
      isSuccess: false,
      token: null,
      user: null,
    );
  }

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? token,
    AuthEntity? user,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, token, user];
}
