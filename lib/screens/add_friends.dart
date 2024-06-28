import 'package:chat_app/services/user_service.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({super.key});

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
    late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().fetchUsers();
  }
  @override
  Widget build(BuildContext context) {
      return AlertDialog(
      backgroundColor: Colors.lightGreen,
      contentPadding: const EdgeInsets.only(bottom: 50),
      title: const Text(
        'test',
        style: null,
      ),
      content: SizedBox(
        height: 400,
        width: 350,
        child: Column(
          children: [
            Flexible(
              child: test(context),
            ),
          ],
        ),
      ),
    );
  }
   Widget test(BuildContext context) {
    return FutureBuilder<List<User>>(
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
              User user = snapshot.data![index];
              return ListTile(
                title: Text(user.username),
                subtitle: Text(user.email),
              );
            },
          );
        }
      },
    );
  }

}