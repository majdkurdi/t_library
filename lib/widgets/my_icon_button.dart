import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final Icon icon;
  final Function() onTap;
  MyIconButton({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: icon,
    );
  }
}
