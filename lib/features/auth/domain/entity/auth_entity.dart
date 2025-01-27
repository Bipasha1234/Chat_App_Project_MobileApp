import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String email;
  final String fullName;
  final String password;
  final String? profilePic;

  const AuthEntity({
    this.userId,
    required this.email,
    required this.fullName,
    required this.password,
    this.profilePic,
  });

  @override
  List<Object?> get props => [userId, email, fullName, password, profilePic];
}
