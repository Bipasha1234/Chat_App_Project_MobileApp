import 'package:cool_app/bloc/onboarding_bloc.dart';
import 'package:cool_app/serviceLocator/service_locator.dart';
import 'package:cool_app/view/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      home: BlocProvider.value(
        value: serviceLocator<OnboardingBloc>(),
        child: const OnboardingScreen(),
      ),
    );
  }
}
