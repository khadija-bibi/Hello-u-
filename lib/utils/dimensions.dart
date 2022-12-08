import 'package:flutter/material.dart';
import 'package:say_hello_to_world/screens/notification.dart';
import 'package:say_hello_to_world/screens/settings.dart';
import '../screens/feed_screen.dart';
import '../screens/to_post.dart';
const webScreenSize=600;
List<Widget> homeScreenItems = [
  FeedScreen(),
  Text("Reels"),
  ToPost(),
  Notifications(),
  Settings(),
];
