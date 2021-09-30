import 'package:flutter/material.dart';
import 'package:t_library/widgets/auth_text_form_field.dart';
import 'package:t_library/widgets/login_button.dart';
import 'package:t_library/widgets/screens_background.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();

  final _loginButtonFocusNode = FocusNode();

  bool _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreensBackground(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 25),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: AuthTextFormField(
                        hintText: 'email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        nextFocusNode: _passwordFocusNode,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 24, right: 24),
                      child: AuthTextFormField(
                        hintText: 'password',
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        nextFocusNode: _loginButtonFocusNode,
                        textInputAction: TextInputAction.done,

                        obscureText: _hidePassword,
                        icon: IconButton(
                          icon: Icon(_hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        ),
                        //TODO show password
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
                    )
                  ],
                ),
              ),
              LoginButton(
                text: 'log in',
                onPressed: () {},
                focusNode: _loginButtonFocusNode,
              ),
              TextButton(
                //TODO add logic and style
                focusNode: _loginButtonFocusNode,
                onPressed: null,
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
