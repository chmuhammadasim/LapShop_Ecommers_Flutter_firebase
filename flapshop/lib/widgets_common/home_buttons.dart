import 'package:flapshop/consts/consts.dart';
import 'package:flutter/material.dart';

Widget homebutton({width, height, icon, String? title, onPress}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
        ),
        10.heightBox,
        title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      ],
    ).box.rounded.white.size(width, height).shadowSm.make(),
  );
}
