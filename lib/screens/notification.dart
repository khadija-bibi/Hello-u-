import 'package:flutter/material.dart';

import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'log_in.dart';
class  Notification extends StatefulWidget {
  const  Notification({Key? key}) : super(key: key);


  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  Future<void> _signOut() async {

    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => const Login()), (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("Sign out"),
          onPressed: ()=>_signOut(),
        ),
      ),

    );
  }
}
