import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshop/consts/consts.dart';
import 'package:flapshop/controllers/cart_controller.dart';
import 'package:flapshop/services/firestore_services.dart';
import 'package:flapshop/views/cart_screen/shipping_screen.dart';
import 'package:flapshop/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shoppping Cart"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FireStoreService.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            "${data[index]['img']}",
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          title:
                              "${data[index]['title']} (x${data[index]['qty']})"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                          subtitle: "${data[index]['tprice']}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .size(14)
                              .color(fontGrey)
                              .make(),
                          trailing: const Icon(
                            Icons.delete,
                            color: redColor,
                          ).onTap(
                            () {
                              FireStoreService.deleteDocument(data[index].id);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(
                        () => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .color(redColor)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .roundedSM
                      .width(context.screenWidth - 60)
                      .color(Colors.lightBlue)
                      .make(),
                  10.heightBox,
                  /* SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          color: redColor,
                          onPress: () {},
                          textColor: whiteColor,
                          title: "Proceed to Shipping"),
                    ), */
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        width: context.screenWidth - 60,
        child: ourButton(
            color: redColor,
            onPress: () {
              Get.to(() => const ShippingDetails());
            },
            textColor: whiteColor,
            title: "Proceed to Shipping"),
      ),
    );
  }
}
