import 'dart:io';

import 'package:chat_app/chat_screen.dart';
import 'package:chat_app/friends_list.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/profile_photo.dart';
import 'package:chat_app/screens/add_user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserModel userModel = UserModel(id: 5, username: 'Angelo', email: 'Angelo.van.osch@hotmail.com', isOnline: true, role: 'User');
  final double coverHeight = 150;
  final double profileHeight = 144;

  File? _profilePhoto;
  File? _banner;

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

  Widget bannerAndProfilePhoto(UserModel userModel) {

    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(bottom: bottom),
        child: banner(userModel),
      ),
      Positioned(
        top: top,
        child: profilePhoto(userModel),
      ),
    ],
  );
}

Widget banner(UserModel userModel) {
  return Stack(
    children: [
      userModel.banner?.isEmpty ?? true && _banner == null
          ? Container(
              color: Colors.grey,
              width: double.infinity,
              height: coverHeight,
            )
          : Container(
              child: _banner == null
                  ? Image.network(
                      userModel.banner ?? 'https://wallpapers.com/images/high/plain-black-with-small-holes-qjgwc84puvsumykc.webp',
                      width: double.infinity,
                      height: coverHeight,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      _banner!,
                      width: double.infinity,
                      height: coverHeight,
                      fit: BoxFit.cover,
                    ),
            ),
      Positioned(
        top: 0,
        right: 20,
        child: Container(
          width: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              _pickBannerPhoto(ImageSource.gallery);
            },
            icon: const Icon(
              Icons.create,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
      ),
    ],
  );
}

Future<void> _pickBannerPhoto(ImageSource source) async {
  final pickedFile = await ImagePicker().pickImage(source: source);

  setState(
    () {
      if (pickedFile != null) {
        _banner = File(pickedFile.path);
      }
    },
  );
}

Widget profilePhoto(UserModel userModel) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 10,
          ),
        ),
        child: userModel.profilePhoto?.isEmpty ?? true && _profilePhoto == null
            ? ProfilePhoto(userModel.profilePhoto, userModel.username, userModel.isOnline, 'myProfilePhoto')
            : ClipOval(
                child: _profilePhoto == null
                    ? ProfilePhoto(userModel.profilePhoto, userModel.username, userModel.isOnline, 'myProfilePhoto')
                    : CircleAvatar(
                        radius: profileHeight / 2,
                        backgroundColor: Colors.grey.shade800,
                        child: Image.file(
                          _profilePhoto!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: coverHeight,
                        ),
                      ),
              ),
      ),
      Positioned(
        top: 100,
        right: 10,
        child: Container(
          width: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              _pickProfilePhoto(ImageSource.gallery);
            },
            icon: const Icon(
              Icons.create,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
      ),
    ],
  );
}

Future<void> _pickProfilePhoto(ImageSource source) async {
  final pickedFile = await ImagePicker().pickImage(source: source);

  setState(
    () {
      if (pickedFile != null) {
        _profilePhoto = File(pickedFile.path);
      }
    },
  );
}
}