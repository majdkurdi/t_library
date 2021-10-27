import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constatnts.dart';
import '../notifiers/auth_notifier.dart';
import '../screens/confirm_account_screen.dart';
import '../screens/main_screen.dart';
import '../widgets/login.dart';
import '../widgets/login_button.dart';
import '../widgets/screens_background.dart';
import '../widgets/signup.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  Future<void> submitForm() async {
    print('submitted');
    var validation = _formKey.currentState!.validate();
    if (!validation) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'wrong input',
            textAlign: TextAlign.center,
          ),
          backgroundColor: kWhiteColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(36),
          duration: Duration(milliseconds: 800),
        ),
      );
      return;
    }
  }

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
                  Form(
                    key: _formKey,
                    child: authType == AuthType.LogIn
                        ? Login(
                            emailController: _emailController,
                            passwordController: _passwordController,
                            onSubmit: submitForm,
                          )
                        : Signup(
                            nameController: _nameController,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            confirmPasswordController:
                                _confirmPasswordController,
                            addressController: _addressController,
                            phoneNumberController: _phoneNumberController,
                          ),
                  ),
                  Consumer(
                    builder: (context, watch, _) {
                      final auth = watch(authProvider);
                      return LoginButton(
                        text: authType == AuthType.LogIn
                            ? 'log in'
                            : 'create account',
                        onPressed: () async {
                          submitForm();
                          if (authType == AuthType.LogIn) {
                            final loggedIn = await auth.login(
                                _emailController.text,
                                _passwordController.text);
                            if (loggedIn == 'done') {
                              Navigator.of(context)
                                  .pushReplacementNamed(MainScreen.routeName);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(loggedIn)));
                            }
                          } else {
                            final signedUp = await auth.signUp(
                                email: _emailController.text,
                                password: _passwordController.text,
                                address: _addressController.text,
                                phoneNumber: _phoneNumberController.text,
                                name: _nameController.text);
                            if (signedUp) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (ctx) => ConfirmAccountScreen()))
                                  .then((val) {
                                if (val == true) {
                                  setState(() => authType = AuthType.LogIn);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Signed up successfuly, you can login now!')));
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error!')));
                            }
                          }
                        },
                      );
                    },
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
