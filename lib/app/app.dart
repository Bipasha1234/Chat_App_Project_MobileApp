import 'package:cool_app/app/di/di.dart';
import 'package:cool_app/core/theme/theme_cubit.dart';
import 'package:cool_app/features/splash/presentation/view/splash_view.dart';
import 'package:cool_app/features/splash/presentation/view_model/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SplashCubit>()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Chat App',
            theme: theme,
            home: const SplashView(),
          );
        },
      ),
    );
  }
}
