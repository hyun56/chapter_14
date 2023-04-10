// 사용자가 채팅하기 전에 로그인하는 화면
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

//import 'package:section_14/widgets/auth_form.dart';
import 'package:section_14/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult; // AuthResult -> UserCredential

    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user!.uid + '.jpg'); // add !

        await ref.putFile(image);

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance // Firestore -> FirebaseFirestore
            .collection('users')
            .doc(authResult.user!.uid) // document -> doc, add !
            .set({
          // setData -> set
          'username': username,
          'email': email,
          'image_url': url
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, pleas check your credentials!';

      if (err.message != null) {
        message = err.message!; // add !
      }

      ScaffoldMessenger.of(ctx) // Scaffold -> ScaffoldMessenger
          .showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx)
              .colorScheme
              .error, // errorColor -> colorScheme.error
        ),
      );
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
