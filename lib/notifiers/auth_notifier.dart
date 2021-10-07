import '../models/user.dart';
import '../services/auth.dart';

class AuthNotifier {
  AuthNotifier._internal();
  static AuthNotifier? _instance;

  factory AuthNotifier() {
    if (_instance == null) {
      _instance = AuthNotifier._internal();
    }
    return _instance!;
  }
  final auth = Auth();
  User? _currentUser;

  Future<bool> login(String email, String password) async {
    try {
      _currentUser = await auth.logIn(email: email, password: password);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  String? get token {
    return _currentUser?.token;
  }
}
