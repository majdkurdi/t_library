import 'package:flutter/material.dart';
import 'package:t_library/constatnts.dart';
import 'package:t_library/screens/login_screen.dart';
import 'package:t_library/widgets/screens_background.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then(
      (value) =>
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreensBackground(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Image(
                      image: AssetImage(logoPath),
                      fit: BoxFit.contain,
                      width: 180,
                      height: 180,
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 150,
            // ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(29),
                  child: Text(
                    'TasQment',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: '',
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
