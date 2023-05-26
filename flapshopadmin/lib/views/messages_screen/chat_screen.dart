import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/views/messages_screen/components/chat_bubble.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: fontGrey,
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(
          text: chats,
          color: fontGrey,
          size: 18.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: ((contex, index) {
                  return chatBubble();
                }),
              ),
            ),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: "Enter a message...",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: purpleColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
