import 'package:flapshop/consts/consts.dart';
import 'package:flutter/material.dart';

Widget orderPlacedDetails({t1, t2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$t1".text.fontFamily(bold).make(),
            "$d1".text.color(redColor).fontFamily(semibold).make(),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$t2".text.fontFamily(bold).make(),
            "$d2".text.color(redColor).fontFamily(semibold).make(),
          ],
        ),
      ],
    ),
  );
}
