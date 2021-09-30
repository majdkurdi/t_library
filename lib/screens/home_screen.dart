import 'package:flutter/material.dart';
import '../constatnts.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(logoPath)),
    );
  }
}
