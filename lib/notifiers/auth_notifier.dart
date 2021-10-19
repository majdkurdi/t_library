import 'package:flutter/cupertino.dart';

import '../models/user.dart';
import '../services/auth.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier._internal();
  static AuthNotifier? _instance;

  factory AuthNotifier() {
    if (_instance == null) {
      _instance = AuthNotifier._internal();
    }
    return _instance!;
  }
  final _auth = Auth();
  User? _currentUser;

  Future<bool> login(String email, String password) async {
    try {
      _currentUser = await _auth.logIn(email: email, password: password);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<bool> updateUser(
      String name, String phoneNumber, String address) async {
    //TODO: implement update user here
    return true;
  }

  void logout() {
    _currentUser = null;
  }

  String? get token {
    return _currentUser?.token;
  }

  User? get user {
    return _currentUser;
  }
}
