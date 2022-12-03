import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../utils/dimensions.dart';
class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: width > webScreenSize
          ? null
          : AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: false,
        title: Text("Hello U",
            style: TextStyle(
              fontFamily: 'DancingScript',
              color: Colors.white70,

              fontWeight: FontWeight.bold,
            )),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.messenger_outline,
              // color: primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
