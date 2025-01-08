import 'package:cool_app/app.dart';
import 'package:cool_app/serviceLocator/service_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    const App(),
  );
}
