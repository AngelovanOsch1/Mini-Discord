import 'package:chat_app/screens/home.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/signup.dart';
import 'package:chat_app/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage _storage = FlutterSecureStorage();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: TokenStorage.getAccessToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator while waiting
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Show error if there's an error
        } else {
          final initialRoute = snapshot.hasData ? 'homeScreen' : 'loginScreen'; 
          return MaterialApp(
            theme: themeData,
            initialRoute: initialRoute,
            routes: {
              'signupScreen': (context) => const SignupScreen(),
              'loginScreen': (context) => const LoginScreen(),
              'homeScreen': (context) => const Home(),
            },
          );
        }
      },
    );
  }
}