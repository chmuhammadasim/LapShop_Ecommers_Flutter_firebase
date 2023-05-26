import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';

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
            boldText(text: "$t1", color: purpleColor),
            boldText(text: "$d1", color: red),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: "$t2", color: purpleColor),
            boldText(text: "$d2", color: fontGrey),
          ],
        ),
      ],
    ),
  );
}
