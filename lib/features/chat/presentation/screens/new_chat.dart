import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewChat extends StatefulWidget {
  const NewChat({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewChatState();
  }
}

class _NewChatState extends State<NewChat> {
  var _chatController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  void _sendChat() async {
    final enteredChat = _chatController.text;

    if (enteredChat.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _chatController.clear();

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredChat,
      'created_at': Timestamp.now(),
      'user_id': user.uid,
      'username': userData.data()!['username'],
      'user_avatar': userData.data()!['image_url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _chatController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(labelText: 'Type message...'),
          )),
          IconButton(
            onPressed: _sendChat,
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
