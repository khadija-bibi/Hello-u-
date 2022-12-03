import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:say_hello_to_world/resources/storage_methods.dart';
import 'package:say_hello_to_world/models/userModel.dart' as model;

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //User details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }
  //SIGNUP
  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,


  }) async {
    String hit = "There is an error";
    try {
      if (email.isNotEmpty || name.isNotEmpty || password.isNotEmpty ||
          bio.isNotEmpty ||file!=null) {
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(credentials.user!.uid);

        String photoURL=await StorageMethods().uploadImageToStorage("profilePictures", file, false);


        model.User user= model.User(
          name:name,
          uid:credentials.user!.uid,
          email:email,
          bio:bio,
          followers:[],
          following:[],
          photoUrl:photoURL,

        );
        await _firestore.collection("users").doc(credentials.user!.uid).set(user.toJson());
        hit="success";
      }

    } catch (err) {
      hit = err.toString();
    }
    return hit;
  }
  //LOGIN
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}