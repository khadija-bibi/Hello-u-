import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String userId;
  final String name;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  const Post(
      {required this.description,
        required this.userId,
        required this.name,
        required this.likes,
        required this.postId,
        required this.datePublished,
        required this.postUrl,
        required this.profImage,
      });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot["description"],
        userId: snapshot["uid"],
        likes: snapshot["likes"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        name: snapshot["username"],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage']
    );
  }

  Map<String, dynamic> toJson() => {
    "description": description,
    "uid": userId,
    "likes": likes,
    "username": name,
    "postId": postId,
    "datePublished": datePublished,
    'postUrl': postUrl,
    'profImage': profImage
  };
}