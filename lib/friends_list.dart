import 'package:chat_app/chat_list.dart';
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

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Container(
        color: Colors.grey.shade800,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 40),
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
                    child: const MyProfile(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Divider(
                color: Theme.of(context).dividerColor,
                thickness: 1,
              ),
              const Expanded(child: ChatList()),
                          Divider(
                color: Theme.of(context).dividerColor,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(alignment: Alignment.topLeft, child: IconButton(onPressed: () => {}, icon: const Icon(Icons.logout, color: Colors.red, size: 40,),),),
              )
            ],
          ),
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
          child: EditProfile(),
        ),
      );
    },
  );
}

  void _mouseEnter(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });
  }
}
