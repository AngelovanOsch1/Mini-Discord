import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/profile_photo.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final UserModel userModel = UserModel(id: 5, username: 'Angelo', email: 'Angelo.van.osch@hotmail.com', isOnline: true, role: 'User');

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            ProfilePhoto(userModel.profilePhoto, userModel.username, userModel.isOnline, 'chatScreenPhoto'),
            const SizedBox(height: 10,),
            Text(userModel.username, style: const TextStyle(fontSize: 20),),
          ],
        ),
      );
  }
}