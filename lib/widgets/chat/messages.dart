import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:section_14/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth
          .instance.currentUser!), // add Future.value(), add !, delete ()
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy(
                'createdAt',
                descending: true,
              )
              .snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapshot.data!.docs; // add !

            return ListView.builder(
              reverse: true,
              itemCount:
                  chatSnapshot.data!.docs.length, // add !, documents -> docs
              itemBuilder: (ctx, index) => MessageBubble(
                chatDocs[index]['text'],
                chatDocs[index]['username'],
                chatDocs[index]['image_url'],
                chatDocs[index]['userId'] == futureSnapshot.data!.uid, // add !
                key: ValueKey(chatDocs[index].id), // documentID -> id
              ),
            );
          },
        );
      },
    );
  }
}
