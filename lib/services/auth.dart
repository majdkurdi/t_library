import 'dart:convert';

import 'package:http/http.dart' as http;
import './http_service.dart';
import '../models/auth_response.dart';
// import '../models/user.dart';

class Auth {
  Auth._internal();

  static Auth? _instance;

  factory Auth() {
    if (_instance == null) {
      _instance = Auth._internal();
    }
    return _instance!;
  }

  Future<AuthResponse?> signUp({
    required String name,
    required String email,
    required String password,
    required String address,
    required String phoneNumber,
  }) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/signup'), body: {
        "name": name,
        "email": email,
        "password": password,
        "phone_number": phoneNumber,
        "address": address
      });
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      return AuthResponse.fromJson(responseBody);
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<AuthResponse?> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/login'),
          body: {"email": email, "password": password});
      print(response.body);
      if (jsonDecode(response.body) == 'Wrong Credentials') return null;
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      print(responseBody);
      return AuthResponse.fromJson(responseBody);
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await get('/logout');
      print('logged out!');
    } on Exception catch (_) {
      rethrow;
    }
  }
}
