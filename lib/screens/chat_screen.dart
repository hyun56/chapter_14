import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .doc('FGOoCk0JsfH0oSVlgHuJ')
            .collection('messages')
            .snapshots(), // 컬렉션 호출 가능
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              // add const
              child: CircularProgressIndicator(),
            );
          }
          final documents =
              streamSnapshot.data!.docs; // add !, documents -> docs
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.all(8), // add const
              child: Text(documents[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), // add const
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats')
              .doc('FGOoCk0JsfH0oSVlgHuJ')
              .collection('messages')
              .add({'text': 'This was added by clicking the button!'});
        },
      ),
    );
  }
}
