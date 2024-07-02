import 'package:chat_app/profile_photo.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late Future<List<UserModel>> futureUsers;
  final TextEditingController searchController = TextEditingController();
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade800,
      contentPadding: const EdgeInsets.only(bottom: 50),
      content: SizedBox(
        height: 400,
        width: 350,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 20, bottom: 10, left: 20),
          child: Column(
            children: [
              searchBar(),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: addUsersList(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return TextField(
      controller: searchController,
      textInputAction: TextInputAction.search,
      onChanged: (value) {},
      decoration: const InputDecoration(
        hintText: 'Search...',
        suffixIcon: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget addUsersList(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: futureUsers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              UserModel userModel = snapshot.data![index];
              return userTile(userModel);
            },
          );
        }
      },
    );
  }

  Widget userTile(UserModel userModel) {
    return Column(
      children: [
        GestureDetector(
          child: MouseRegion(
            onEnter: (_) => _mouseEnter(true),
            onExit: (_) => _mouseEnter(false),
            cursor: SystemMouseCursors.click,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, right: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfilePhoto(
                    userModel.profilePhoto,
                    userModel.username,
                    userModel.isOnline,
                    'chatScreenPhoto',
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    userModel.username,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      userModel.role,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Colors.grey[400]!,
                        width: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
        ),
      ],
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });
  }
}
