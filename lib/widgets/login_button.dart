import 'package:flutter/material.dart';
import 'package:t_library/constatnts.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);
  final String text;
  final void Function() onPressed;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: kBorderRadius,
        color: kWhiteColor,
      ),
      child: TextButton(
        focusNode: focusNode,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
