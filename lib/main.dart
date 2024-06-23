import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      initialRoute: 'signupScreen',
      routes: {
        'signupScreen': (context) => const SignupScreen(),
        'loginScreen': (context) => const LoginScreen(),
      },
    );
  }
}