import 'package:flutter/material.dart';
class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "ITS Web",style: TextStyle(
          fontSize: 40,
          color: Colors.black87,
        ),
        ),
      ),
    );
  }
}
