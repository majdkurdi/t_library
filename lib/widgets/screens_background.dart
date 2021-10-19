import 'package:flutter/material.dart';

import '../constatnts.dart';

class ScreensBackground extends StatelessWidget {
  const ScreensBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(loginBackgroundPath),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
