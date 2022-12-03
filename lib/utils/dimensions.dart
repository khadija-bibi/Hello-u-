import 'package:flutter/material.dart';

import '../screens/feed_screen.dart';
import '../screens/to_post.dart';
const webScreenSize=600;
List<Widget> homeScreenItems = [
  FeedScreen(),
  Text("Reels"),
  ToPost(),
  // Notification(),
  Text("Messages"),
];
