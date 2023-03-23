import 'package:flutter/material.dart';
import 'package:section_14/screens/auth_screen.dart';
import 'package:section_14/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
          secondary: Colors.deepPurple,
          // brightness: Brightness.dark,
        ),
        // primaryColor: Colors.pink,

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink, // 버튼 배경색
            foregroundColor: Colors.white, // 글씨색
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),

        /*textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.pink,
        )),*/
      ),
      home: AuthScreen(),
    );
  }
}
