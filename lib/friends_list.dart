import 'dart:io';

import 'package:chat_app/edit_profile.dart';
import 'package:chat_app/my_profile.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  bool _isHovering = false;

  File? profilePhoto;
  File? banner;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Container(
        color: Colors.grey.shade800,
        child: Column(
          children: [
            GestureDetector(
              onTap: _editProfile,
              child: MouseRegion(
                onEnter: (_) => _mouseEnter(true),
                onExit: (_) => _mouseEnter(false),
                cursor: SystemMouseCursors.click,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: _isHovering ? Colors.grey.shade700 : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: MyProfile(),
                  ),
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  void _editProfile() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 500,
          height: 500,
          child: EditProfile(profilePhoto, banner),
        ),
        actions: [
                Align(
        alignment: Alignment.bottomRight,
        child: Padding(
                padding: const EdgeInsets.all(16),
                child: FloatingActionButton(
                  onPressed: () {
                    _saveProfile();
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.save),
                ),
              ),
      ),

        ],
      );
    },
  );
}

  void _mouseEnter(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });
  }

  void _saveProfile() {
    print(profilePhoto);
  }
}
