import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/services/store_services.dart';
import 'package:flapshopadmin/views/messages_screen/chat_screen.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

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
          text: message,
          color: fontGrey,
          size: 18.0,
        ),
      ),
      body: StreamBuilder(
        stream: StoreService.getMessage(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(red),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var t = data[index]['created_on'] == null
                        ? DateTime.now()
                        : data[index]['created_on'].toDate();
                    var time = intl.DateFormat("h:mma").format(t);
                    return ListTile(
                      onTap: () {
                        Get.to(
                          () => const ChatScreen(),
                        );
                      },
                      leading: const CircleAvatar(
                        backgroundColor: purpleColor,
                        child: Icon(
                          Icons.person,
                          color: white,
                        ),
                      ),
                      title: boldText(
                          text: "${data[index]['sender_name']}",
                          color: fontGrey),
                      subtitle: normalText(
                          text: "${data[index]['last_msg']}", color: darkGrey),
                      trailing: normalText(text: "10:45", color: darkGrey),
                    );
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
