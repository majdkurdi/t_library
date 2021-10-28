import 'package:flutter/material.dart';
import '../widgets/screens_background.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ScreensBackground(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 65),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            color: Colors.white.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Notifications:',
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Notification(),
                          Notification(),
                          Notification(),
                          Notification(),
                          Notification(),
                          Notification(),
                          Notification(),
                          Notification(),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      )),
    );
  }
}

class Notification extends StatelessWidget {
  const Notification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.8),
            child: Image.asset('assets/images/t.library-logo.png'),
            radius: 30,
          ),
          title: Text(
            'Your books Order has been submitted',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          trailing: Text(
            '9:30',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Divider(
          color: Colors.white,
          thickness: 1,
        ),
      ],
    );
  }
}
