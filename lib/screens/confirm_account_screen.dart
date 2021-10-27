import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/auth_notifier.dart';
import '../widgets/screens_background.dart';
import '../widgets/simple_text_field.dart';

class ConfirmAccountScreen extends StatefulWidget {
  @override
  State<ConfirmAccountScreen> createState() => _ConfirmAccountScreenState();
}

class _ConfirmAccountScreenState extends State<ConfirmAccountScreen> {
  final _codeTextController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    _codeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Scaffold(
            appBar: AppBar(
              title: Text('Confirm Your Account'),
              backgroundColor: Colors.transparent,
            ),
            extendBodyBehindAppBar: true,
            body: ScreensBackground(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text('Enter Your Verfication Code:',
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(30),
                        child: SimpleTextField(
                            hint: 'Verfication code ...',
                            controller: _codeTextController,
                            fun: () {
                              setState(() {});
                            })),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_codeTextController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Invalid Code!'),
                              ));
                              return;
                            }
                            setState(() => loading = true);
                            await context
                                .read(authProvider)
                                .verify(_codeTextController.text);
                            setState(() => loading = false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Verified!'),
                            ));
                            Navigator.of(context).pop(true);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Verify',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  _codeTextController.text.isEmpty
                                      ? Colors.grey.withOpacity(0.5)
                                      : Colors.black.withOpacity(0.7)))),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (loading)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.2),
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )),
            )
        ]),
      ),
    );
  }
}
