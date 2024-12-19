import 'package:cool_app/core/app_theme/app_theme.dart';
import 'package:cool_app/view/onboarding_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: getApplicationTheme(),
        // theme: ThemeData(
        //   primarySwatch: Colors.orange,
        //   scaffoldBackgroundColor: Colors.grey[200],
        // ),
        routes: {
          '/': (context) => const OnboardingScreen(),
        });
  }
}
