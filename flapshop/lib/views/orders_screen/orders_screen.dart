import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshop/services/firestore_services.dart';
import 'package:flapshop/views/orders_screen/orders_details.dart';
import 'package:flutter/material.dart';
import 'package:flapshop/consts/consts.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Order".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreService.getALLOrder(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "NO Orders yet".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  leading: "${index + 1}."
                      .text
                      .color(darkFontGrey)
                      .fontFamily(bold)
                      .xl
                      .make(),
                  title: data[index]['order_by']
                      .toString()
                      .text
                      .color(redColor)
                      .fontFamily(semibold)
                      .make(),
                  subtitle: data[index]['total_amount']
                      .toString()
                      .numCurrency
                      .text
                      .fontFamily(bold)
                      .make(),
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(() => OrdersDetails(
                            data: data[index],
                          ));
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: darkFontGrey,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
