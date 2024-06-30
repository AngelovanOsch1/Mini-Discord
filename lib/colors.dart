// theme.dart

import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  fontFamily: 'interFontFamily',
  inputDecorationTheme: const InputDecorationTheme(
    errorMaxLines: 2,
    labelStyle: TextStyle(color: Color(0xFFFFFFFF)),
    hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF72767D)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF7289DA)),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF7289DA),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF805600),
    onSecondary: Color(0xFFFFFFFF),
    background: Color(0xFF36393F),
    onBackground: Color(0xFF9A9A9A),
    surface: Color(0xFF2F3136),
    onSurface: Color(0xFFFFFFFF),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF7289DA),
    insetPadding: EdgeInsets.only(left: 30),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
          (states) => const Color(0xFF7289DA)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  dividerColor: const Color(0xFF4F545C),
);

const TextTheme textTheme = TextTheme(
  headlineLarge: TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w900,
  ),
  headlineMedium: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  ),
  headlineSmall: TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
);
