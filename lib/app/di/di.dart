import 'package:cool_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:cool_app/core/network/api_service.dart';
import 'package:cool_app/core/network/hive_service.dart';
import 'package:cool_app/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:cool_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:cool_app/features/auth/data/repository/auth_local_repository.dart';
import 'package:cool_app/features/auth/data/repository/auth_remote_repository.dart';
import 'package:cool_app/features/auth/domain/use_case/login_usecase.dart';
import 'package:cool_app/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:cool_app/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:cool_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:cool_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:cool_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initRegisterDependencies() {
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(getIt<Dio>()),
  );

  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton(
    () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(registerUseCase: getIt(), uploadImageUsecase: getIt()),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}
