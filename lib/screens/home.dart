import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/friends_list.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/add_user.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserModel userModel = UserModel(id: 5, username: 'Angelo', email: 'Angelo.van.osch@hotmail.com', isOnline: true, role: 'User');
  final double coverHeight = 150;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddUser();
            },
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
      body: const Row(children: [
        FriendsList(),
        Expanded(child: ChatScreen())
      ],),
    );
  }
}