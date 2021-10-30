import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t_library_package/notifiers/auth_notifier.dart';

import '../constatnts.dart';
import '../screens/auth_screen.dart';
import '../widgets/screens_background.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool editing = false;
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  String? name;
  String? phone;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: Consumer(builder: (ctx, watch, _) {
          final auth = watch(authProvider);
          return ScreensBackground(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  if (editing) {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      setState(() => loading = true);
                                      final updated = await auth.updateUser(
                                          name!, phone!, address!);
                                      setState(() => loading = false);
                                      if (!updated) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text('Error, try again!')));
                                      }
                                    }
                                  }
                                  setState(() => editing = !editing);
                                },
                                icon: Icon(editing ? Icons.check : Icons.edit,
                                    color: Colors.white)),
                            PopupMenuButton(
                                color: Colors.white,
                                icon:
                                    Icon(Icons.more_vert, color: Colors.white),
                                onSelected: (i) async {
                                  print(1);
                                  setState(() => loading = true);
                                  await auth.logout();
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AuthScreen.routeName, (route) => false);
                                },
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                          value: 1,
                                          child: Row(
                                            children: [
                                              Icon(Icons.logout),
                                              SizedBox(width: 20),
                                              Text('LogOut')
                                            ],
                                          ))
                                    ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              border: Border.all(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80))),
                          child: Image(
                            image:
                                AssetImage('assets/images/t.library-logo.png'),
                          ),
                        ),
                      ),
                      Container(
                        width: (auth.user?.name.length.toDouble() ?? 1) * 25,
                        child: TextFormField(
                          enabled: editing,
                          textAlign: TextAlign.center,
                          initialValue: auth.user?.name,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                          decoration: kAccoutTextFieldDecoration,
                          validator: (val) {
                            if (val != null) {
                              return null;
                            } else {
                              return 'Invalid name';
                            }
                          },
                          onSaved: (val) {
                            name = val;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Card(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration:
                                        kAccoutTextFieldDecoration.copyWith(
                                            prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.white.withOpacity(0.5),
                                    )),
                                    initialValue: auth.user?.phoneNumber,
                                    enabled: editing,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    validator: (val) {
                                      if (val != null && val.length > 8) {
                                        return null;
                                      } else {
                                        return 'Invalid Phone number!';
                                      }
                                    },
                                    onSaved: (val) {
                                      phone = val;
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  TextFormField(
                                    decoration:
                                        kAccoutTextFieldDecoration.copyWith(
                                            prefixIcon: Icon(
                                      Icons.home,
                                      color: Colors.white.withOpacity(0.5),
                                    )),
                                    initialValue: auth.user?.address,
                                    enabled: editing,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    maxLines: 2,
                                    validator: (val) {
                                      if (val != null) {
                                        return null;
                                      } else {
                                        return 'Invalid Address';
                                      }
                                    },
                                    onSaved: (val) {
                                      address = val;
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
      if (loading)
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.2),
          child: Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          )),
        ),
    ]);
  }
}
