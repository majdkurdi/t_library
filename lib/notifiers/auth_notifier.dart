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

  Future<String> login(String email, String password) async {
    try {
      _currentUser = await _auth.logIn(email: email, password: password);
      if (_currentUser != null) {
        await rememberUser(_currentUser!);
        return 'done';
      } else {
        return 'Wrong Credentials';
      }
    } on Exception catch (_) {
      return 'Error!';
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

  Future logout() async {
    try {
      await _auth.logOut();
      _currentUser = null;
      await clearUser();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<bool> signUp(
      {required String email,
      required String password,
      required String address,
      required String phoneNumber,
      required String name}) async {
    try {
      _currentUser = await _auth.signUp(
          name: name,
          email: email,
          password: password,
          address: address,
          phoneNumber: phoneNumber);
      await rememberUser(_currentUser!);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  String? get token {
    return _currentUser?.token;
  }

  User? get user {
    return _currentUser?.user;
  }
}
