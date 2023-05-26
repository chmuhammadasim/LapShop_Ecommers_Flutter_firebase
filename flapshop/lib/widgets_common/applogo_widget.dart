import 'package:flapshop/consts/consts.dart';
import 'package:flutter/material.dart';

Widget appLogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .black
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
