import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';

Widget chatBubble() {
  return Directionality(
    //textDirection:
    //    data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    textDirection: TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      decoration: const BoxDecoration(
        //color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
        color: purpleColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //"${data['msg']}".text.color(whiteColor).size(16).make(),
          normalText(text: "Tour Message here...", color: white),
          10.heightBox,
          //time.text.color(whiteColor.withOpacity(0.5)).make(),
          normalText(text: "10:45PM", color: darkGrey)
        ],
      ),
    ),
  );
}
