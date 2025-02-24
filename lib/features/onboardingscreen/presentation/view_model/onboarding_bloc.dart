import 'package:cool_app/features/auth/presentation/view/login_view.dart';
import 'package:cool_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBloc extends Cubit<void> {
  OnboardingBloc(this._loginBloc) : super(null);

  final LoginBloc _loginBloc;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 30), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _loginBloc,
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }
}
