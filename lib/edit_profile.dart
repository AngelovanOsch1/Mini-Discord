import 'dart:io';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  File? profilePhoto;
  File? banner;

  EditProfile(
    this.profilePhoto,
    this.banner, {
    super.key,
  });


  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserModel userModel = UserModel(id: 5, username: 'Angelo', email: 'Angelo.van.osch@hotmail.com', isOnline: true);
  final double coverHeight = 150;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Container( child: bannerAndProfilePhoto(userModel),);
  }
    Widget bannerAndProfilePhoto(UserModel userModel) {

    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.topCenter,
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
      userModel.banner?.isEmpty ?? true && widget.banner == null
          ? Container(
              color: Colors.grey,
              width: double.infinity,
              height: coverHeight,
            )
          : Container(
              child: widget.banner == null
                  ? Image.network(
                      userModel.banner ?? 'https://wallpapers.com/images/high/plain-black-with-small-holes-qjgwc84puvsumykc.webp',
                      width: double.infinity,
                      height: coverHeight,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      widget.banner!,
                      width: double.infinity,
                      height: coverHeight,
                      fit: BoxFit.cover,
                    ),
            ),
      Positioned(
        top: 0,
        right: 10,
        child: Container(
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
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
        widget.banner = File(pickedFile.path);
      }
    },
  );
}

Widget profilePhoto(UserModel userModel) {
  return Stack(
    children: [
      Container(
        child: userModel.profilePhoto?.isEmpty ?? true && widget.profilePhoto == null
            ? ProfilePhoto(userModel.profilePhoto, userModel.username, userModel.isOnline, 'myProfilePhoto')
            : ClipOval(
                child: widget.profilePhoto == null
                    ? ProfilePhoto(userModel.profilePhoto, userModel.username, userModel.isOnline, 'myProfilePhoto')
                    : CircleAvatar(
                        radius: profileHeight / 2,
                        backgroundColor: Colors.grey.shade800,
                        child: Image.file(
                          widget.profilePhoto!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: coverHeight,
                        ),
                      ),
              ),
      ),
      Positioned(
        top: 90,
        right: 5,
        child: Container(
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
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
        widget.profilePhoto = File(pickedFile.path);
      }
    },
  );
}

}