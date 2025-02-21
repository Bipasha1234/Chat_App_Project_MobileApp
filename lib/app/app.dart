import 'package:cool_app/app/di/di.dart';
import 'package:cool_app/core/theme/app_theme.dart';
import 'package:cool_app/features/splash/presentation/view/splash_view.dart';
import 'package:cool_app/features/splash/presentation/view_model/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: AppTheme.getApplicationTheme(isDarkMode: false),
      home: BlocProvider.value(
        value: getIt<SplashCubit>(),
        child: const SplashView(),
      ),
    );
  }
}
