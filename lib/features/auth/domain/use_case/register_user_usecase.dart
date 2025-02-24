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




// import 'package:cool_app/app/usecase/usecase.dart';
// import 'package:cool_app/core/error/failure.dart';
// import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
// import 'package:cool_app/features/auth/domain/repository/auth_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RegisterUserParams extends Equatable {
//   final String email;
//   final String fullName;
//   final String password;
//   final String? profilePic;

//   const RegisterUserParams({
//     required this.email,
//     required this.fullName,
//     required this.password,
//     this.profilePic,
//   });

//   //intial constructor
//   const RegisterUserParams.initial({
//     required this.email,
//     required this.fullName,
//     required this.password,
//     this.profilePic,
//   });

//   @override
//   List<Object?> get props => [email, fullName, password, profilePic];
// }

// class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
//   final IAuthRepository repository;

//   RegisterUseCase(this.repository);

//   @override
//   Future<Either<Failure, void>> call(RegisterUserParams params) async {
//     // Convert RegisterUserParams to AuthEntity
//     final authEntity = AuthEntity(
//       email: params.email,
//       fullName: params.fullName,
//       password: params.password,
//       profilePic: params.profilePic,
//     );

//     // Call the repository to register the user
//     final result = await repository.registerUser(authEntity);

//     return result.fold(
//       (failure) => Left(failure), // Return failure if registration fails
//       (success) async {
//         // On successful registration, save user data in SharedPreferences
//         final sharedPreferences = await SharedPreferences.getInstance();

//         await sharedPreferences.setString('fullName', params.fullName);
//         await sharedPreferences.setString('email', params.email);
//         if (params.profilePic != null) {
//           await sharedPreferences.setString('profilePic', params.profilePic!);
//         }

//         return Right(success); // Return success after saving the data
//       },
//     );
//   }
// }

