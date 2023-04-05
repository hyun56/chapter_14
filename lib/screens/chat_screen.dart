import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:section_14/widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      /*body: StreamBuilder(
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
      ),*/
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
          ],
        ),
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
