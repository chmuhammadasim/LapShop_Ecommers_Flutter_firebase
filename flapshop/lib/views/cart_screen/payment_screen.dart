import 'package:flapshop/consts/lists.dart';
import 'package:flapshop/controllers/cart_controller.dart';
import 'package:flapshop/views/home_screen/home.dart';
import 'package:flapshop/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flapshop/consts/consts.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "Payment Method"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .make()),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                      orderPaymentMethod:
                          paymentMethod[controller.paymentIndex.value],
                      totalAmount: controller.totalP.value,
                    );
                    await controller.clearCart();
                    VxToast.show(context, msg: "Order placed successfully");
                    Get.offAll(const Home());
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: "Place Order",
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: List.generate(
                paymentMethod.length,
                (index) => GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : Colors.transparent,
                        width: 4,
                        style: BorderStyle.solid,
                      ),
                    ),
                    margin: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodImg[index],
                          width: double.infinity,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.5)
                              : Colors.transparent,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  value: true,
                                  onChanged: (value) {},
                                ),
                              )
                            : Container(),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: paymentMethod[index]
                              .text
                              .white
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
