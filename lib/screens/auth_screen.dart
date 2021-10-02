import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/login_button.dart';
import '../widgets/login_form.dart';
import '../widgets/screens_background.dart';
import '../widgets/signup_form.dart';

enum AuthType {
  LogIn,
  SignUp,
}

class AuthScreen extends StatefulWidget {
  static const routeName = '/login';
  AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthType authType = AuthType.LogIn;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: ScreensBackground(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 25),
                  authType == AuthType.LogIn ? LoginForm() : SignupForm(),
                  LoginButton(
                    text: authType == AuthType.LogIn
                        ? 'log in'
                        : 'create account',
                    onPressed: () {
                      print('pressed');
                    },
                    //TODO login or sign up
                    // submitForm,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        authType == AuthType.SignUp
                            ? authType = AuthType.LogIn
                            : authType = AuthType.SignUp;
                      });
                    },
                    child: Text(
                      authType == AuthType.SignUp ? 'log in' : 'Sign up',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
