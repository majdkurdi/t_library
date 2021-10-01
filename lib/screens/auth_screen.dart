import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:t_library/widgets/auth_text_form_field.dart';
import 'package:t_library/widgets/login_button.dart';
import 'package:t_library/widgets/screens_background.dart';

import '../constatnts.dart';

enum Auth {
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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _adressController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _adressFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _loginButtonFocusNode = FocusNode();
  var _hideLoginPassword = true;
  var _hideSignUpPassword = true;

  var auth = Auth.LogIn;

  void submitForm() {
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
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(36),
          duration: Duration(milliseconds: 800),
        ),
      );
      return;
    }
    //TODO submit form
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: auth == Auth.LogIn
                          ? <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: AuthTextFormField(
                                  hintText: 'email',
                                  autoFocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  nextFocusNode: _passwordFocusNode,
                                  validator: (value) {
                                    if (!value!.contains('@') ||
                                        !value.contains('.com')) {
                                      return 'input valid email';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 24, right: 24),
                                child: AuthTextFormField(
                                  hintText: 'password',
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  nextFocusNode: _loginButtonFocusNode,
                                  textInputAction: TextInputAction.done,
                                  obscureText: _hideLoginPassword,
                                  icon: IconButton(
                                    icon: Icon(_hideLoginPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _hideLoginPassword =
                                            !_hideLoginPassword;
                                      });
                                    },
                                  ),
                                  validator: (value) {
                                    if (value!.length < 6) {
                                      return 'password should be at least 6 charechters';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'forget password ?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ]
                          : <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 24),
                                child: AuthTextFormField(
                                  hintText: 'name',
                                  autoFocus: true,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  controller: _nameController,
                                  focusNode: _nameFocusNode,
                                  nextFocusNode: _emailFocusNode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'name should not be empty';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 24),
                                child: AuthTextFormField(
                                  hintText: 'email',
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  nextFocusNode: _adressFocusNode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'email should not be empty';
                                    } else if (!value.contains('@') ||
                                        !value.contains('.com')) {
                                      return 'input valid email';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 24),
                                child: AuthTextFormField(
                                  hintText: 'address',
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  controller: _adressController,
                                  focusNode: _adressFocusNode,
                                  nextFocusNode: _passwordFocusNode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'address should not be empty';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 24),
                                child: AuthTextFormField(
                                  hintText: 'password',
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  nextFocusNode: _confirmPasswordFocusNode,
                                  obscureText: _hideSignUpPassword,
                                  icon: IconButton(
                                    icon: Icon(_hideSignUpPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _hideSignUpPassword =
                                            !_hideSignUpPassword;
                                      });
                                    },
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'password should not be empty';
                                    } else if (value.length < 6) {
                                      return 'password should be at least 6 charechters';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 24, right: 24),
                                child: AuthTextFormField(
                                  hintText: 'confirm password',
                                  controller: _confirmPasswordController,
                                  focusNode: _confirmPasswordFocusNode,
                                  nextFocusNode: _loginButtonFocusNode,
                                  textInputAction: TextInputAction.done,
                                  obscureText: _hideSignUpPassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'password should not be empty';
                                    } else if (value.length < 6) {
                                      return 'password should be at least 6 charechters';
                                    } else if (_passwordController.text !=
                                        _confirmPasswordController.text) {
                                      return 'incorrect password';
                                    }
                                  },
                                ),
                              ),
                            ],
                    ),
                  ),
                  LoginButton(
                    text: auth == Auth.LogIn ? 'log in' : 'create account',
                    onPressed:
                        //TODO login or sign up
                        submitForm,
                    focusNode: _loginButtonFocusNode,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        auth == Auth.SignUp
                            ? auth = Auth.LogIn
                            : auth = Auth.SignUp;
                      });
                    },
                    child: Text(
                      auth == Auth.SignUp ? 'log in' : 'Sign up',
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
