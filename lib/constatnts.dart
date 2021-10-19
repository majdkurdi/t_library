import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String logoPath = 'assets/images/t.library-logo.png';
const String tasQmentLogo = 'assets/images/tasqment-logo.png';
const String loginBackgroundPath = 'assets/images/login-background.jpg';
const kBorderRadius = BorderRadius.all(Radius.circular(20));
final kWhiteColor = Colors.white.withOpacity(0.4);
const kAccoutTextFieldDecoration = InputDecoration(
  disabledBorder: InputBorder.none,
  enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2)),
);
