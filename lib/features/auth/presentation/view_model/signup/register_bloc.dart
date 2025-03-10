import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cool_app/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:cool_app/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   final RegisterUseCase _registerUseCase;
//   final UploadImageUsecase _uploadImageUsecase;

//   RegisterBloc({
//     required RegisterUseCase registerUseCase,
//     required UploadImageUsecase uploadImageUsecase,
//   })  : _registerUseCase = registerUseCase,
//         _uploadImageUsecase = uploadImageUsecase,
//         super(const RegisterState.initial()) {
//     on<RegisterUser>(_onRegisterEvent);
//     on<UploadImage>(_onLoadImage);
//   }

//   void _onRegisterEvent(
//     RegisterUser event,
//     Emitter<RegisterState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));
//     final result = await _registerUseCase.call(RegisterUserParams(
//       fullName: event.fullName,
//       email: event.email,
//       password: event.password,
//       profilePic: state.imageName,
//     ));

//     result.fold(
//       (l) {
//         emit(state.copyWith(isLoading: false, isSuccess: false));
//         showMySnackBar(
//             context: event.context, message: l.message, color: Colors.red);
//       },
//       (r) {
//         emit(state.copyWith(isLoading: false, isSuccess: true));
//         showMySnackBar(
//             context: event.context, message: "Registration Successful");
//       },
//     );
//   }

//   void _onLoadImage(
//     UploadImage event,
//     Emitter<RegisterState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));
//     final result = await _uploadImageUsecase.call(
//       UploadImageParams(
//         file: event.file,
//       ),
//     );

//     result.fold(
//       (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
//       (r) {
//         emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
//       },
//     );
//   }
// }
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  RegisterBloc({
    required RegisterUseCase registerUseCase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(const RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);
    on<UploadImage>(_onLoadImage);
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      fullName: event.fullName,
      email: event.email,
      password: event.password,
      profilePic: state.imageName,
    ));

    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        // Here we don't handle SnackBar, just emit failure state
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        // Success state, no SnackBar here
      },
    );
  }

  void _onLoadImage(
    UploadImage event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
