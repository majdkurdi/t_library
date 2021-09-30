import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_library/constatnts.dart';

class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField({
    Key? key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.icon,
    this.obscureText,
    this.keyboardType,
    this.textInputAction,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final Widget? icon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction,
      onFieldSubmitted: nextFocusNode != null
          ? (_) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          : null,
      textAlign: TextAlign.start,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        hintText: hintText ?? '',
        fillColor: kWhiteColor,
        filled: true,
        suffixIcon: icon,
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 0, color: Theme.of(context).accentColor),
          borderRadius: kBorderRadius,
        ),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(width: 0, color: Theme.of(context).accentColor),
          borderRadius: kBorderRadius,
        ),
      ),
    );
  }
}
