import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      fontFamily: 'OpenSans Medium',
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color(0xFF80CBB2),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF80CBB2),
        onPrimary: Colors.white,
        error: Colors.red,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        labelStyle: const TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xFF80CBB2)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: const Color(0xFF80CBB2), // Default background color
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Default corner radius
          ),
        ),
      ));
}
