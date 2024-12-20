import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Set the primary color for the app, also used for AppBar and FloatingActionButton
    // primarySwatch: Colors.orange,
    fontFamily: 'OpenSans Medium',
    // Background color for the scaffold (entire screen)
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFF80CBB2),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF80CBB2),
      onPrimary: Colors.white,

      error: Colors.red,

      // Default font family for text throughout the app
    ),
    // Styling for Elevated Buttons in the app
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily:
              'OpenSans Bold', // Font style for text inside ElevatedButton
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // Rounded corners for ElevatedButton
        ),
      ),
    ),

    // AppBar styling (for the top navigation bar)
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      // color: Colors.yellow, // Set the background color of the AppBar
      elevation: 4, // Add shadow effect for AppBar
      shadowColor: Colors.black, // Set shadow color of the AppBar
      titleTextStyle: TextStyle(
        fontSize: 22,
        color: Colors.black, // Title color
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans Bold', // Title font weight
      ),
    ),

    // IconButton Theme (For customizing IconButton styles globally)
    iconTheme: const IconThemeData(
      color: Colors.black, // Set the color of all icons
      size: 24, // Set default icon size
    ),

    // Text button styling globally
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     textStyle: const TextStyle(
    //       fontSize: 19,
    //       fontWeight: FontWeight.normal,
    //       // color: Colors.orange, // Text color for all TextButton widgets
    //     ),
    //   ),
    // ),
  );
}
