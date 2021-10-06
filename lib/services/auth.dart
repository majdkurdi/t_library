import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/user.dart';

const String baseUrl = 'http://192.168.137.1:8000/api';

class Auth {
  Auth._internal();

  static Auth? _instance;

  factory Auth() {
    if (_instance == null) {
      _instance = Auth._internal();
    }
    return _instance!;
  }

  Future<User?> signUp({
    required String name,
    required String email,
    required String password,
    required String address,
    required int phoneNumber,
  }) async {
    try {
      final signUpUrl = Uri.parse(''); //TODO add signUpUrl
      final response = await http.post(signUpUrl);
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      return User.fromJson(responseBody);
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final logInUrl = Uri.parse('$baseUrl/login'); //TODO add logInUrlUrl
      final response = await http
          .post(logInUrl, body: {"email": email, "password": password});
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      print(responseBody);
      return User.fromJson(responseBody);
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
