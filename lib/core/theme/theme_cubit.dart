import 'package:bloc/bloc.dart';
import 'package:cool_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.getApplicationTheme(isDarkMode: false));

  void toggleTheme(bool isDarkMode) {
    emit(AppTheme.getApplicationTheme(isDarkMode: isDarkMode));
  }
}
