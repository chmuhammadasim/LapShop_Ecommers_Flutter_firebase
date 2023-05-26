import 'package:flapshop/controllers/cart_controller.dart';
import 'package:flapshop/views/cart_screen/payment_screen.dart';
import 'package:flapshop/widgets_common/custom_textfield.dart';
import 'package:flapshop/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flapshop/consts/consts.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: () {
            //if (controller.phonecontroller.text.length == 11) {
            Get.to(() => const PaymentMethod());
            //} else {
            ///  VxToast.show(context, msg: "Enter Correct phone number");
            //}
          },
          color: redColor,
          textColor: whiteColor,
          title: "continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
              title: "Address",
              hint: "Address",
              isPass: false,
              controller: controller.addresscontroller,
            ),
            customTextField(
              title: "City",
              hint: "City",
              isPass: false,
              controller: controller.citycontroller,
            ),
            customTextField(
              title: "State",
              hint: "State",
              isPass: false,
              controller: controller.statecontroller,
            ),
            customTextField(
              title: "Postal Code",
              hint: "Postal Code",
              isPass: false,
              controller: controller.postalcodecontroller,
            ),
            customTextField(
              title: "Phone",
              hint: "Phone",
              isPass: false,
              controller: controller.phonecontroller,
            ),
          ],
        ),
      ),
    );
  }
}
