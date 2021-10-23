import 'package:flutter/cupertino.dart';

import '../models/auth_response.dart';
import '../models/user.dart';
import '../services/auth.dart';
import '../services/shared_prefrences.dart';
import '../services/user.dart';

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
  final _userService = UserService();
  AuthResponse? _currentUser;

  Future<bool> login(String email, String password) async {
    try {
      _currentUser = await _auth.logIn(email: email, password: password);
      await rememberUser(_currentUser!);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<void> quickLogIn() async {
    _currentUser = await getSavedUser();
  }

  Future<bool> updateUser(
      String name, String phoneNumber, String address) async {
    try {
      _currentUser?.user = (await _userService.updateUser(
          name: name, phoneNumber: phoneNumber, address: address))!;
      await rememberUser(_currentUser!);
      print('updated');
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  void logout() async {
    _currentUser = null;
    await clearUser();
  }

  String? get token {
    return _currentUser?.token;
  }

  User? get user {
    return _currentUser?.user;
  }
}
