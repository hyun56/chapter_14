import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:section_14/widgets/chat/messages.dart';
import 'package:section_14/widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final fbm = FirebaseMessaging
        .instance; // FirebaseMessaging -> FirebaseMessaging.instance
    // fbm.requestPermission();
    fbm.requestPermission(alert: true, announcement: false, sound: true);

    /* fbm.configure(onMessage: (msg) {
      // configure가 없어짐.. https://firebase.flutter.dev/docs/migration/
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    }); */

    FirebaseMessaging.onMessage.listen((msg) {
      print(msg);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      print(msg);
      return;
    });

    fbm.subscribeToTopic('chat');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: [
          DropdownButton(
            underline: Container(),
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
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
