import 'package:flutter/material.dart';

import '../constatnts.dart';
import '../services/auth.dart';
import 'auth_text_form_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm();
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  var _hideSignUpPassword = true;

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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: AuthTextFormField(
              hintText: 'email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: _emailController,
              focusNode: _emailFocusNode,
              nextFocusNode: _addressFocusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'email should not be empty';
                } else if (!value.contains('@') || !value.contains('.com')) {
                  return 'input valid email';
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: AuthTextFormField(
              hintText: 'address',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: _addressController,
              focusNode: _addressFocusNode,
              nextFocusNode: _phoneNumberFocusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'address should not be empty';
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: AuthTextFormField(
              hintText: 'phone number',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: _phoneNumberController,
              focusNode: _phoneNumberFocusNode,
              nextFocusNode: _passwordFocusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'address should not be empty';
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
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
                    _hideSignUpPassword = !_hideSignUpPassword;
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
            padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
            child: AuthTextFormField(
              hintText: 'confirm password',
              controller: _confirmPasswordController,
              focusNode: _confirmPasswordFocusNode,
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
              onSubmit: submitForm,
            ),
          ),
        ],
      ),
    );
  }
}
