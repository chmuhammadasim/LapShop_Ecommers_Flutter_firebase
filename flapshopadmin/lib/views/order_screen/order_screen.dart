import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/controller/order_controller.dart';
import 'package:flapshopadmin/services/store_services.dart';
import 'package:flapshopadmin/views/order_screen/order_deatils.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrderController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: normalText(
              text: intl.DateFormat('EEE,MMM d, ' 'yy').format(DateTime.now()),
              color: purpleColor,
            ),
          ),
          10.widthBox,
        ],
        title: boldText(
          text: order,
          color: darkGrey,
          size: 18.0,
        ),
      ),
      body: StreamBuilder(
        stream: StoreService.getOrders(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(red),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "NO Orders yet".text.color(fontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) {
                      //var time = data[index]['order_date'];
                      return ListTile(
                        onTap: () {
                          Get.to(() => OrderDetails(
                                data: data[index],
                              ));
                        },
                        leading: Image.network(
                          "${data[index]['orders'][0]['image']}",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: boldText(
                          text: "${data[index]['order_code']}",
                          color: fontGrey,
                          size: 16.0,
                        ),
                        subtitle: Column(
                          children: [
                            5.heightBox,
                            /* Row(
                              children: [
                                const Icon(Icons.calendar_month),
                                10.widthBox,
                                normalText(
                                  color: darkGrey,
                                  text:
                                      intl.DateFormat().add_yMEd().format(time),
                                )
                              ],
                            ), */
                            5.heightBox,
                            Row(
                              children: [
                                const Icon(Icons.price_change),
                                10.widthBox,
                                normalText(
                                    text: "${data[index]['total_amount']}",
                                    color: darkGrey),
                              ],
                            )
                          ],
                        ),
                        trailing:
                            boldText(text: unpaid, color: fontGrey, size: 16.0),
                      )
                          .box
                          .outerShadowSm
                          .margin(const EdgeInsets.only(bottom: 5))
                          .make();
                    },
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
