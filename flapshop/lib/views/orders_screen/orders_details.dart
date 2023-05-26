import 'package:flapshop/views/orders_screen/components/order_placed_details.dart';
import 'package:flapshop/views/orders_screen/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:flapshop/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  orderStatus(
                    color: redColor,
                    icon: Icons.done,
                    title: "Placed",
                    showDone: data['order_placed'],
                  ),
                  orderStatus(
                    color: Colors.blue,
                    icon: Icons.thumb_up,
                    title: "Confirmed",
                    showDone: data['order_confirmed'],
                  ),
                  orderStatus(
                    color: Colors.yellow,
                    icon: Icons.car_rental,
                    title: "Delivery",
                    showDone: data['order_on_delivery'],
                  ),
                  orderStatus(
                    color: Colors.green,
                    icon: Icons.done_all_rounded,
                    title: "Delivered",
                    showDone: data['order_delivered'],
                  ),
                  const Divider(),
                  10.heightBox,
                  orderPlacedDetails(
                    d1: data['order_code'],
                    d2: data['shipping_method'],
                    t1: "Order Code",
                    t2: "Shipping Method",
                  ),
                  10.heightBox,
                  orderPlacedDetails(
                    //d1: intl.DateFormat()
                    //    .add_yMd()
                    //    .format((data['order_data'].toDate())),
                    d2: data['payment_method'],
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
                            "Shipping Address".text.fontFamily(bold).make(),
                            "${data['order_by_name']}"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_email']}"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_postalcode']}"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_address']}"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_city']}"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_state']}"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            "${data['order_by_phone']}"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          children: [
                            "Total Amount".text.fontFamily(bold).make(),
                            "${data['total_amount']}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  10.heightBox,
                  "Ordered Product"
                      .text
                      .size(16)
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .makeCentered(),
                  10.heightBox,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(data['orders'].length, (index) {
                      return orderPlacedDetails(
                        t1: data['orders'][index]['title'],
                        d2: data['orders'][index]['tprice'],
                        d1: "${data['orders'][index]['qty']}x",
                        t2: "Price",
                      );
                    }).toList(),
                  ).box.make(),
                  const Divider(),
                  20.heightBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
