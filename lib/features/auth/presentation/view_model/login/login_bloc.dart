import 'package:cool_app/core/common/snackbar/my_snackbar.dart';
import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:cool_app/features/auth/domain/use_case/get_current_user_usecase.dart'; // Import your getCurrentUser UseCase
import 'package:cool_app/features/auth/domain/use_case/login_usecase.dart';
import 'package:cool_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:cool_app/features/home/presentation/view/home_view.dart';
import 'package:cool_app/features/home/presentation/view_model/home_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final LoginUseCase _loginUseCase;
  final GetCurrentUserUseCase
      _getCurrentUserUseCase; // Add the GetCurrentUserUseCase

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required LoginUseCase loginUseCase,
    required GetCurrentUserUseCase
        getCurrentUserUseCase, // Inject the GetCurrentUserUseCase
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        _loginUseCase = loginUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase, // Initialize it
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _registerBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<NavigateHomeScreenEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _homeCubit,
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      // Step 1: Login and get token
      final result = await _loginUseCase(
        LoginParams(
          email: event.email,
          password: event.password,
        ),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          showMySnackBar(
            context: event.context,
            message: "Invalid Credentials",
            color: Colors.red,
          );
        },
        (token) {
          // Emit state after login is successful
          emit(state.copyWith(isLoading: false, isSuccess: true, token: token));

          // Now fetch current user details using the token
          add(FetchCurrentUserEvent(token: token, context: event.context));
        },
      );
    });

    on<FetchCurrentUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      // Step 2: Fetch current user details using the token
      final userResult = await _getCurrentUserUseCase(event.token);

      userResult.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          showMySnackBar(
            context: event.context,
            message: "Failed to fetch user details",
            color: Colors.red,
          );
        },
        (user) async {
          // Emit state with user details and navigate to Home screen
          emit(state.copyWith(
            isLoading: false,
            isSuccess: true,
            user: user,
          ));

          // Optional delay before navigating
          await Future.delayed(const Duration(milliseconds: 500));

          // Navigate to the Home screen after async operation is complete
          add(
            NavigateHomeScreenEvent(
              context: event.context,
              destination: HomeView(user: user), // Pass user data to HomeView
            ),
          );
        },
      );
    });
  }
}
