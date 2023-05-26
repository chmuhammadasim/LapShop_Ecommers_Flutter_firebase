import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/controller/order_controller.dart';
import 'package:flapshopadmin/views/order_screen/components/order_placed_details.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:flapshopadmin/views/widget/our_button.dart';
import 'package:get/get.dart';

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrderController>();
  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: fontGrey,
            onPressed: () {
              Get.back();
            },
          ),
          title: boldText(
            text: "Order Details",
            color: fontGrey,
            size: 18.0,
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
              color: green,
              onPress: () {
                controller.confirmed(true);
                controller.changeStatus(
                  title: "order_confirmed",
                  status: true,
                  docId: widget.data.id,
                );
              },
              title: "Confirm order",
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Visibility(
                  visible: !controller.confirmed.value,
                  child: Column(
                    children: [
                      boldText(
                          text: "Order Status", color: purpleColor, size: 18.0),
                      SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {
                          value = true;
                        },
                        title: boldText(text: "Placed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: boldText(text: "Confirmed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.onDelivery.value,
                        onChanged: (value) {
                          controller.onDelivery.value = value;
                          controller.changeStatus(
                            title: "order_on_delivery",
                            status: value,
                            docId: widget.data.docId,
                          );
                        },
                        title: boldText(text: "on Delivery", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value = value;
                          controller.changeStatus(
                            title: "order_delivered",
                            status: value,
                            docId: widget.data.docId,
                          );
                        },
                        title: boldText(text: "Delivered", color: fontGrey),
                      ),
                    ],
                  ).box.outerShadowMd.white.border(color: lightGrey).make(),
                ),
                Column(
                  children: [
                    orderPlacedDetails(
                      d1: widget.data['order_code'],
                      d2: widget.data['shipping_method'],
                      t1: "Order Code",
                      t2: "Shipping Method",
                    ),
                    10.heightBox,
                    orderPlacedDetails(
                      //d1: intl.DateFormat()
                      //    .add_yMd()
                      //    .format((data['order_data'].toDate())),
                      d2: widget.data['payment_method'],
                      t1: "Order Date",
                      t2: "Payment Method",
                    ),
                    10.heightBox,
                    orderPlacedDetails(
                      d1: "UnPaid",
                      d2: "Order Placed",
                      t1: "Payment Status",
                      t2: "Delivery Status",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Shipping Address"
                                  .text
                                  .color(purpleColor)
                                  //.fontFamily(bold)
                                  .make(),
                              "${widget.data['order_by_name']}"
                                  .text
                                  .color(red)
                                  //.fontFamily(semibold)
                                  .make(),
                              "${widget.data['order_by_email']}"
                                  .text
                                  .color(red)
                                  //.fontFamily(semibold)
                                  .make(),
                              "${widget.data['order_by_postalcode']}"
                                  .text
                                  .color(red)
                                  //.fontFamily(semibold)
                                  .make(),
                              "${widget.data['order_by_address']}"
                                  .text
                                  .color(red)
                                  //.fontFamily(semibold)
                                  .make(),
                              "${widget.data['order_by_city']}"
                                  .text
                                  .color(red)
                                  //.fontFamily(semibold)
                                  .make(),
                              "${widget.data['order_by_state']}"
                                  .text
                                  .color(red)
                                  //.fontFamily(semibold)
                                  .make(),
                              "${widget.data['order_by_phone']}"
                                  .text
                                  .color(red)
                                  //.fontFamily(semibold)
                                  .make(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            children: [
                              boldText(
                                  text: "Total Amount", color: purpleColor),
                              boldText(
                                  text: "${widget.data['total_amount']}",
                                  color: red,
                                  size: 16.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ).box.outerShadowMd.white.border(color: lightGrey).make(),
                const Divider(),
                10.heightBox,
                boldText(text: "Ordered Products", color: fontGrey, size: 16.0),
                10.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                    controller.orders.length,
                    (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlacedDetails(
                            t1: "${controller.orders[index]['title']}",
                            d2: "${controller.orders[index]['tprice']}",
                            d1: "${controller.orders[index]['qty']}x",
                            t2: "Price",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 30,
                              height: 20,
                              color: Color(controller.orders[index]['color']),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ).toList(),
                )
                    .box
                    .outerShadowMd
                    .white
                    .margin(const EdgeInsets.only(bottom: 4))
                    .make(),
                const Divider(),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
