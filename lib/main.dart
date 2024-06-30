import 'package:chat_app/screens/home.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/signup.dart';
import 'package:chat_app/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: TokenStorage.getAccessToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final initialRoute = snapshot.hasData ? 'homeScreen' : 'loginScreen'; 
          return MaterialApp(
            theme: themeData,
            initialRoute: initialRoute,
            debugShowCheckedModeBanner: false,
            routes: {
              'signupScreen': (context) => const SignupScreen(),
              'loginScreen': (context) => const LoginScreen(),
              'homeScreen': (context) => const HomeScreen(),
            },
          );
        }
      },
    );
  }
}