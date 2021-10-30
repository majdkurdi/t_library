import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t_library_package/notifiers/auth_notifier.dart';
import '../widgets/screens_background.dart';
import '../widgets/simple_text_field.dart';

class DoResetPasswordScreen extends StatefulWidget {
  @override
  State<DoResetPasswordScreen> createState() => _DoResetPasswordScreenState();
}

class _DoResetPasswordScreenState extends State<DoResetPasswordScreen> {
  final codeTextController = TextEditingController();
  final passTextController = TextEditingController();
  final confirmPassTextController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Your Password'),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: ScreensBackground(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 4),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SimpleTextField(
                          controller: codeTextController,
                          fun: () {},
                          hint: 'Enter Your Verfication Code'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SimpleTextField(
                          controller: passTextController,
                          fun: () {},
                          obsecure: true,
                          hint: 'Enter Your new Password'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SimpleTextField(
                          controller: confirmPassTextController,
                          fun: () {},
                          obsecure: true,
                          hint: 'Confirm Your new Password'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (codeTextController.text.isEmpty ||
                                passTextController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Invalid!'),
                              ));
                              return;
                            } else if (passTextController.text !=
                                confirmPassTextController.text) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('passwords dont match!'),
                              ));
                              return;
                            }
                            FocusScope.of(context).unfocus;
                            setState(() => loading = true);
                            final done = await context
                                .read(authProvider)
                                .doResetPassword(codeTextController.text,
                                    passTextController.text);
                            setState(() => loading = false);
                            if (done) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('password changed, try login!'),
                              ));
                              Navigator.of(context).pop();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ٌReset',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  codeTextController.text.isEmpty
                                      ? Colors.grey.withOpacity(0.5)
                                      : Colors.black.withOpacity(0.7)))),
                    )
                  ],
                ),
              ),
            ),
            if (loading)
              Container(
                color: Colors.black.withOpacity(0.5),
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )),
              )
          ],
        ),
      ),
    );
  }
}
