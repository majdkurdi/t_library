import 'package:flutter/material.dart';
import 'package:t_library/screens/auth_screen.dart';
import './screens/welcome_screen.dart';
import './screens/home_screen.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SEGEOPR',
        primaryColor: Color(0xFF363636),
        accentColor: Color(0xFF800000),
        hintColor: Color(0xFF0B1A0B).withOpacity(0.5),
        backgroundColor: Colors.black,
        buttonColor: Colors.white,
      ),
      initialRoute: WelcomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        AuthScreen.routeName: (ctx) => AuthScreen(),
        WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
      },
    );
  }
}
