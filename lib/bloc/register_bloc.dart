import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<UpdateEmail>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<UpdatePassword>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<UpdateConfirmPassword>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<SubmitRegistration>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, errorMessage: null));

      await Future.delayed(const Duration(seconds: 2)); // Simulated delay

      final errorMessage = _validateInputs(
        state.email,
        state.password,
        state.confirmPassword,
      );

      if (errorMessage != null) {
        emit(state.copyWith(isSubmitting: false, errorMessage: errorMessage));
      } else {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      }
    });
  }

  String? _validateInputs(
      String email, String password, String confirmPassword) {
    if (email.isEmpty || !email.contains('@')) {
      return 'Please enter a valid email.';
    }
    if (password.isEmpty || password.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }
}
