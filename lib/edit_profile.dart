import 'dart:io';
import 'dart:typed_data';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


// ignore: must_be_immutable
class EditProfile extends StatefulWidget {

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserModel userModel = UserModel(id: 5, username: 'Angelo', email: 'Angelo.van.osch@hotmail.com', isOnline: true, role: 'User');
  final double coverHeight = 150;
  final double profileHeight = 144;
  File? _profilePhoto;
  File? _banner;
  XFile? _uploadedProfilePhoto;
  final _storage = const FlutterSecureStorage();



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
      Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TextButton(
                onPressed: () async {
                  saveProfile();
                },
                child: const Text('Save', style: TextStyle(color: Colors.white),
                ),
              ),
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
  final test = await ImagePicker().pickImage(source: source);

  setState(
    () {
      if (test != null) {
        _banner = File(test.path);
      }
    },
  );
}

Widget profilePhoto(UserModel userModel) {
  return Stack(
    children: [
      Container(
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
    _uploadedProfilePhoto = await ImagePicker().pickImage(source: source);

    setState(
      () {
        if (_uploadedProfilePhoto != null) {
          _profilePhoto = File(_uploadedProfilePhoto!.path);
        }
      },
    );
  }

  Future<void> saveProfile() async {
    final token = await _storage.read(key: 'access_token');
    final Uri apiUrl = Uri.parse("http://127.0.0.1:8080/editProfile");
    Uint8List bytes = await _uploadedProfilePhoto!.readAsBytes();

    try {
      final request = http.MultipartRequest("PUT", apiUrl);
      final myFile = http.MultipartFile(
        "file",
        http.ByteStream.fromBytes(bytes),
        bytes.length,
        filename: _uploadedProfilePhoto!.name
        );
        request.files.add(myFile);
        print(_uploadedProfilePhoto!.name);
        request.headers['Authorization'] = 'Bearer $token';
        final response = await request.send();
        
      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }
}