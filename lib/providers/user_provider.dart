import 'package:flutter/material.dart';
import 'package:say_hello_to_world/resources/authentication.dart';

import '../models/userModel.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final Authentication _authentication = Authentication();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authentication.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
