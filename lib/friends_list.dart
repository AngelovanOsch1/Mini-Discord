import 'package:chat_app/chat_list.dart';
import 'package:chat_app/edit_profile.dart';
import 'package:chat_app/my_profile.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/models/user_model.dart';

class FriendsList extends ConsumerStatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends ConsumerState<FriendsList> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final userModel = ref.watch(userModelProvider);

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
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => _logout(userModel!.id),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
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

  Future<void> _logout(int? userId) async {
    try {
      final url = Uri.parse('http://127.0.0.1:8080/logout/$userId');

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        await TokenStorage.clearTokens();
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
        ref.read(userModelProvider.notifier).clearUser();
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Logout failed: ${response.body}')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong!')),
        );
      }
    }
  }
}
