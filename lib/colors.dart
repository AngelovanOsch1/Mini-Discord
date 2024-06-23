// theme.dart

import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  fontFamily: 'interFontFamily',
  scaffoldBackgroundColor: const Color(0xFF36393F), // Discord dark theme background color
  appBarTheme: const AppBarTheme(color: Color(0xFF36393F), elevation: 0),
  inputDecorationTheme: const InputDecorationTheme(
    errorMaxLines: 2,
    labelStyle: TextStyle(color: Color(0xFFFFFFFF)), // White text color
    hintStyle: TextStyle(color: Color(0xFFFFFFFF)), // White text color
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF72767D)), // Discord's border color
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF7289DA)), // Discord's focus border color
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF7289DA), // Discord's primary color
    onPrimary: Color(0xFFFFFFFF), // White text color
    secondary: Color(0xFF805600), // Your original secondary color
    onSecondary: Color(0xFFFFFFFF), // White text color
    background: Color(0xFF36393F), // Discord dark theme background color
    onBackground: Color(0xFF9A9A9A), // Discord's text color for UI elements
    surface: Color(0xFF2F3136), // Discord's surface color
    onSurface: Color(0xFFFFFFFF), // White text color
    error: Color(0xFFBA1A1A), // Your original error color
    onError: Color(0xFFFFFFFF), // White text color
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF7289DA), // Discord's snackbar background color
    insetPadding: EdgeInsets.only(left: 30),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
          (states) => const Color(0xFF7289DA)), // Discord's primary color
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          color: Color(0xFFFFFFFF), // White text color
          fontSize: 24, // Adjust as needed
          fontWeight: FontWeight.bold, // Adjust as needed
        ),
      ),
    ),
  ),
  dividerColor: const Color(0xFF4F545C), // Discord's divider color
);

const TextTheme textTheme = TextTheme(
  headlineLarge: TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w900,
  ), // Placeholder, adjust as per your design
  headlineMedium: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  ), // Placeholder, adjust as per your design
  headlineSmall: TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ), // Placeholder, adjust as per your design
);
