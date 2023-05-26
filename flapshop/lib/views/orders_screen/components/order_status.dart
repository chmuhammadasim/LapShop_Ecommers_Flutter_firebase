import 'package:flapshop/consts/consts.dart';
import 'package:flutter/material.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone ? const Icon(Icons.done, color: redColor) : Container(),
        ],
      ),
    ),
  );
}
