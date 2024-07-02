import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.grey.shade900, child: Center(child: Image.network('https://cdn-icons-png.flaticon.com/512/1380/1380370.png', color: Theme.of(context).colorScheme.primary, height: 150,)),);
  }
}