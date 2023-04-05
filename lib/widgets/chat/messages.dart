import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chats').snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data!.docs; // add !
        return ListView.builder(
          itemCount: chatSnapshot.data!.docs.length, // add !, documents -> docs
          itemBuilder: (ctx, index) => Text(
            chatDocs[index]['text'],
          ),
        );
      },
    );
  }
}
