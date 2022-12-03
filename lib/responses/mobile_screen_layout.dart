import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:say_hello_to_world/providers/user_provider.dart';
import 'package:say_hello_to_world/models/userModel.dart' as model;
import 'package:say_hello_to_world/screens/to_post.dart';

import '../utils/dimensions.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {

    pageController.jumpToPage(page);
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: PageView(
          children: homeScreenItems,
          // physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
          activeColor: Colors.deepPurple,
          items: const <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
              backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie_creation_outlined,
              ),
              label: 'Reels',
              backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box,
              ),
              label: "Post",
              backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              label: 'Notifications',
              backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
              ),
              label: 'Messages',
              backgroundColor: Colors.deepPurple,
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      );
    }
  }

