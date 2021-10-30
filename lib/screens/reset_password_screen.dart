import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t_library_package/notifiers/auth_notifier.dart';
import './do_reset_pass_screen.dart';
import '../widgets/screens_background.dart';
import '../widgets/simple_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailTextController = TextEditingController();
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
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 3),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SimpleTextField(
                      controller: emailTextController,
                      fun: () {},
                      hint: 'Enter Your Email'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (emailTextController.text.isEmpty) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Invalid email!'),
                          ));
                          return;
                        }
                        FocusScope.of(context).unfocus;
                        setState(() => loading = true);
                        final done = await context
                            .read(authProvider)
                            .resetPassword(emailTextController.text);
                        setState(() => loading = false);
                        if (done) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (ctx) => DoResetPasswordScreen()));
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
                              emailTextController.text.isEmpty
                                  ? Colors.grey.withOpacity(0.5)
                                  : Colors.black.withOpacity(0.7)))),
                )
              ],
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
