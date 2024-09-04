import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfile extends ConsumerWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.watch(userModelProvider);

    if (userModel == null) {
      return const Center(child: Text('Loading...'));
    }
    
    return Center(
      child: Column(
        children: [
          ProfilePhoto(
            userModel.profilePhoto,
            userModel.username,
            userModel.isOnline,
            'chatScreenPhoto'
          ),
          const SizedBox(height: 10),
          Text(
            userModel.username,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
