import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  final Function fun;
  final String hint;
  final TextEditingController controller;
  final bool obsecure;
  final bool centerText;

  SimpleTextField(
      {required this.controller,
      required this.fun,
      required this.hint,
      this.obsecure = false,
      this.centerText = false});
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      textAlign: centerText ? TextAlign.center : TextAlign.start,
      obscureText: obsecure,
      onChanged: (_) {
        fun();
      },
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3))),
      controller: controller,
    );
  }
}
