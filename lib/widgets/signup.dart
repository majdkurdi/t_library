import 'package:flutter/material.dart';

import 'auth_text_form_field.dart';

class Signup extends StatefulWidget {
  const Signup({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.addressController,
    required this.phoneNumberController,
    required this.nameController,
    this.onSubmit,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController addressController;
  final TextEditingController phoneNumberController;
  final TextEditingController nameController;
  final Future<void> Function()? onSubmit;

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  var _hideSignUpPassword = true;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _addressFocusNode.dispose();
    _nameFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: AuthTextFormField(
            hintText: 'name',
            autoFocus: true,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: widget.nameController,
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
            controller: widget.emailController,
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
            controller: widget.addressController,
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
            controller: widget.phoneNumberController,
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
            controller: widget.passwordController,
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
            controller: widget.confirmPasswordController,
            focusNode: _confirmPasswordFocusNode,
            textInputAction: TextInputAction.done,
            obscureText: _hideSignUpPassword,
            validator: (value) {
              if (value!.isEmpty) {
                return 'password should not be empty';
              } else if (value.length < 6) {
                return 'password should be at least 6 charechters';
              } else if (widget.passwordController.text !=
                  widget.confirmPasswordController.text) {
                return 'incorrect password';
              }
            },
            onSubmit: (_) async {
              widget.onSubmit;
            },
          ),
        ),
      ],
    );
  }
}
