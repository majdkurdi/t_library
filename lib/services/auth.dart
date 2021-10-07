import 'dart:convert';

import 'package:http/http.dart' as http;
import './http_service.dart';
import '../models/user.dart';

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
      final response = await http.post(Uri.parse('uri'));
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      return User.fromJson(responseBody);
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<User?> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/login'),
          body: {"email": email, "password": password});
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      print(responseBody);
      return User.fromJson(responseBody);
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }
}
