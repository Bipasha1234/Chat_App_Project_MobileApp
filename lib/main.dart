import 'package:cool_app/app/app.dart';
import 'package:cool_app/app/di/di.dart';
import 'package:cool_app/core/common/internet_checker/internet_checker.dart';
import 'package:cool_app/core/network/hive_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  await initDependencies();
  await getIt<InternetConnectivity>().initializeConnectivity();

  runApp(
    const App(),
  );
}
