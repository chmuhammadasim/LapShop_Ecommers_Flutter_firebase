import 'package:flapshop/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailButton({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(70)
      .padding(
        const EdgeInsets.all(
          4,
        ),
      )
      .make();
}
