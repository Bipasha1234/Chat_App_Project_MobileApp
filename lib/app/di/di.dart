import 'package:cool_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:cool_app/core/network/api_service.dart';
import 'package:cool_app/core/network/hive_service.dart';
import 'package:cool_app/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:cool_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:cool_app/features/auth/data/repository/auth_local_repository.dart';
import 'package:cool_app/features/auth/data/repository/auth_remote_repository.dart';
import 'package:cool_app/features/auth/domain/entity/auth_entity.dart';
import 'package:cool_app/features/auth/domain/use_case/get_current_user_usecase.dart';
import 'package:cool_app/features/auth/domain/use_case/login_usecase.dart';
import 'package:cool_app/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:cool_app/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:cool_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:cool_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:cool_app/features/chat/data/data_source/chat_remote_datasource.dart';
import 'package:cool_app/features/chat/data/repository/chat_remote_repository.dart';
import 'package:cool_app/features/chat/domain/use_case/get_messages.dart';
import 'package:cool_app/features/chat/domain/use_case/get_user_sidebar.dart';
import 'package:cool_app/features/chat/domain/use_case/send_message.dart';
import 'package:cool_app/features/chat/presentation/view_model/login/chat_bloc.dart';
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
  await _initChatDependencies();
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
  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(registerUseCase: getIt(), uploadImageUsecase: getIt()),
  );
}

_initHomeDependencies() {
  // Register AuthEntity first
  getIt.registerSingleton<AuthEntity>(
    const AuthEntity(email: '', fullName: '', password: ''),
  );

  // Register HomeCubit and pass AuthEntity instance
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<AuthEntity>()),
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
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
    ),
  );
}

_initChatDependencies() async {
  // getIt.registerLazySingleton<TokenSharedPrefs>(
  //   () => TokenSharedPrefs(getIt<SharedPreferences>()),
  // );

  getIt.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSource(dio: getIt<Dio>()));

  getIt.registerLazySingleton(
    () => ChatRemoteRepository(getIt<ChatRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetUsersForSidebarUseCase>(
    () => GetUsersForSidebarUseCase(
      getIt<ChatRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(
      getIt<ChatRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetMessagesUseCase>(
    () => GetMessagesUseCase(
      chatRepository: getIt<ChatRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<ChatBloc>(
    () => ChatBloc(
        getUsersForSidebarUseCase: getIt(),
        sendMessageUseCase: getIt(),
        getMessagesUseCase: getIt()),
  );
}
