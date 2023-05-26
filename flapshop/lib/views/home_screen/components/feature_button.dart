import 'package:flapshop/consts/consts.dart';
import 'package:flapshop/views/category_screen/category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget featuredButton({
  String? title,
  icon,
}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(
        const EdgeInsets.symmetric(horizontal: 4),
      )
      .color(whiteColor)
      .padding(
        const EdgeInsets.all(4),
      )
      .rounded
      .shadowSm
      .make()
      .onTap(() {
    Get.to(() => CategoriesDeatils(title: title));
  });
}
