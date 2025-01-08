import 'package:cool_app/bloc/chat_bloc.dart';
import 'package:cool_app/bloc/onboarding_bloc.dart';
import 'package:cool_app/bloc/register_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initBloc();
}

void _initBloc() {
  serviceLocator.registerLazySingleton(() => RegisterBloc());
  serviceLocator.registerLazySingleton(() => ChatBloc());
  serviceLocator.registerLazySingleton(() => OnboardingBloc());
}
