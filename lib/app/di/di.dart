import 'package:cool_app/app/shared_prefs/token_shared_prefs.dart';
import 'package:cool_app/core/common/internet_checker/internet_checker.dart';
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
import 'package:cool_app/features/chat/data/data_source/chat_local_datasource.dart';
import 'package:cool_app/features/chat/data/data_source/chat_remote_datasource.dart';
import 'package:cool_app/features/chat/data/repository/chat_local_repository.dart';
import 'package:cool_app/features/chat/data/repository/chat_remote_repository.dart';
import 'package:cool_app/features/chat/domain/use_case/block_user.dart';
import 'package:cool_app/features/chat/domain/use_case/delete_chat.dart';
import 'package:cool_app/features/chat/domain/use_case/get_block_users.dart';
import 'package:cool_app/features/chat/domain/use_case/get_messages.dart';
import 'package:cool_app/features/chat/domain/use_case/get_user_sidebar.dart';
import 'package:cool_app/features/chat/domain/use_case/send_message.dart';
import 'package:cool_app/features/chat/domain/use_case/unblock_user.dart';
import 'package:cool_app/features/chat/presentation/view_model/chat/chat_bloc.dart';
import 'package:cool_app/features/home/presentation/view_model/home_bloc.dart';
import 'package:cool_app/features/onboardingscreen/presentation/view_model/onboarding_bloc.dart';
import 'package:cool_app/features/splash/presentation/view_model/splash_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();

  // Initialize Auth and related services first
  await _initRegisterDependencies();
  await _initLoginDependencies();

  // Then initialize Home and Chat dependencies
  await _initHomeDependencies();
  await _initChatDependencies();

  // Initialize Onboarding and Splash related services last
  await _initSplashScreenDependencies();
  await _initOnboardingScreenDependencies();
  _initInternetConnectivity();
}

void _initInternetConnectivity() {
  getIt.registerLazySingleton<InternetConnectivity>(
      () => InternetConnectivity());
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

//-home--//
_initHomeDependencies() {
  getIt.registerSingleton<AuthEntity>(
    const AuthEntity(email: '', fullName: '', password: ''),
  );

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

//---chat---///
_initChatDependencies() async {
  getIt.registerLazySingleton(
    () => ChatLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton(
    () => ChatLocalRepository(getIt<ChatLocalDataSource>()),
  );
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
  getIt.registerLazySingleton<DeleteChatUsecase>(
    () => DeleteChatUsecase(
      chatRepository: getIt<ChatRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );
  getIt.registerLazySingleton<BlockUserUsecase>(
    () => BlockUserUsecase(
      chatRepository: getIt<ChatRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );
  getIt.registerLazySingleton<UnBlockUserUsecase>(
    () => UnBlockUserUsecase(
      chatRepository: getIt<ChatRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );
  getIt.registerLazySingleton<GetBlockedUsersUseCase>(
    () => GetBlockedUsersUseCase(
      getIt<ChatRemoteRepository>(),
    ),
  );

  getIt.registerFactory<ChatBloc>(
    () => ChatBloc(
        getUsersForSidebarUseCase: getIt(),
        sendMessageUseCase: getIt(),
        getMessagesUseCase: getIt(),
        deleteChatUsecase: getIt(),
        blockUserUsecase: getIt(),
        unblockUserUsecase: getIt(),
        getblockedUserUsecase: getIt()),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnboardingBloc>()),
  );
}

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingBloc>(
    () => OnboardingBloc(getIt<LoginBloc>()),
  );
}
