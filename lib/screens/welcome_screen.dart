import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constatnts.dart';
import '../notifiers/auth_notifier.dart';
import '../screens/auth_screen.dart';
import '../screens/main_screen.dart';
import '../services/shared_prefrences.dart';
import '../widgets/screens_background.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  final authProvider = ChangeNotifierProvider((ref) => AuthNotifier());
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _controller!.forward();
    _controller!.addListener(() {
      // print(_controller!.value);
      // print('valueeeee ${_animation!.value}');
      if (_controller!.isCompleted) {
        _controller!.reverse();
      }
      if (_controller!.isDismissed) {
        _controller!.forward();
      }
      setState(() {});
    });
    Future.delayed(Duration(seconds: 5)).then(
      (_) async {
        if (await isLoggedIn()) {
          await context.read(authProvider).quickLogIn();
          Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
        } else {
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
        }
      },
    );
  }

  @override
  void dispose() {
    _controller!.stop();
    super.dispose();
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
                    child: Opacity(
                      opacity: 0.8,
                      child: Image(
                        image: AssetImage(logoPath),
                        fit: BoxFit.contain,
                        width: 180 + _controller!.value * 10,
                        height: 180 + _controller!.value * 10,
                      ),
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
                child: Stack(
                  clipBehavior: Clip.none,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Positioned(
                      right: 87,
                      bottom: -5,
                      child: Container(
                        height: 75,
                        width: 75,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image(
                            image: AssetImage(tasQmentLogo),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'TasQment',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: '',
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
