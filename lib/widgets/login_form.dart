import 'package:flutter/material.dart';

import '../constatnts.dart';
import '../screens/home_screen.dart';
import '../services/auth.dart';
import 'auth_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();
  var _hideLoginPassword = true;
  final _formKey = GlobalKey<FormState>();

  Future<void> submitForm(_) async {
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
    final auth = Auth();
    final user = await auth.logIn(
        email: _emailController.text, password: _passwordController.text);
    if (user != null) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              //TODO show error here
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
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
                  if (!value!.contains('@') || !value.contains('.com')) {
                    return 'input valid email';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
              child: AuthTextFormField(
                hintText: 'password',
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                textInputAction: TextInputAction.done,
                obscureText: _hideLoginPassword,
                onSubmit: (_) async {
                  await submitForm(_);
                },
                icon: IconButton(
                  icon: Icon(_hideLoginPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _hideLoginPassword = !_hideLoginPassword;
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
          ]),
    );
  }
}
