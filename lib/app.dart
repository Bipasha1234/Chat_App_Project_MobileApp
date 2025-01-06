import 'package:cool_app/bloc/register_bloc.dart';
import 'package:cool_app/core/app_theme/app_theme.dart';
import 'package:cool_app/view/dashboard.dart';
import 'package:cool_app/view/email_otp.dart';
import 'package:cool_app/view/login.dart';
import 'package:cool_app/view/onboarding_screen.dart';
import 'package:cool_app/view/otp_screen.dart';
import 'package:cool_app/view/register.dart';
import 'package:cool_app/view/set_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (_) => RegisterBloc(),
        ),
        // Add other BLoC providers here as needed
      ],
      child: MaterialApp(
        title: 'Chat App',
        theme: getApplicationTheme(),
        initialRoute: '/',
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/signin': (context) => const SignInScreen(),
          '/userProfile': (context) => const UserProfileScreen(),
          '/otp': (context) => const OtpScreen(
                email: 'bipashalamsal@gmail.com',
              ),
          '/chat': (context) => const ChatScreen(),
          '/emailOtpScreen': (context) => const EmailOtpScreen(),
        },
      ),
    );
  }
}
