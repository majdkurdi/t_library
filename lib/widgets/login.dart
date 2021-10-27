import 'package:flutter/material.dart';
import 'package:t_library/screens/reset_password_screen.dart';
import 'auth_text_form_field.dart';

class Login extends StatefulWidget {
  const Login(
      {Key? key,
      required this.emailController,
      required this.passwordController,
      this.onSubmit})
      : super(key: key);
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Future<void> Function()? onSubmit;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();

  var _hideLoginPassword = true;

  // Future<void> submitForm(_) async {
  //   var validation = _formKey.currentState!.validate();
  //   if (!validation) {
  //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'wrong input',
  //           textAlign: TextAlign.center,
  //         ),
  //         backgroundColor: kWhiteColor,
  //         behavior: SnackBarBehavior.floating,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(20),
  //           ),
  //         ),
  //         padding: EdgeInsets.all(12),
  //         margin: EdgeInsets.all(36),
  //         duration: Duration(milliseconds: 800),
  //       ),
  //     );
  //     return;
  //   }
  //   //TODO submit form
  //   final auth = Auth();
  //   final user = await auth.logIn(
  //       email: _emailController.text, password: _passwordController.text);
  //   if (user != null) {
  //     Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
  //   } else {
  //     showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //             //TODO show error here
  //             ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              controller: widget.emailController,
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
              controller: widget.passwordController,
              focusNode: _passwordFocusNode,
              textInputAction: TextInputAction.done,
              obscureText: _hideLoginPassword,
              onSubmit: (_) async {
                widget.onSubmit;
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
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => ResetPasswordScreen()));
              },
              child: Text(
                'forgot password?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]);
  }
}
