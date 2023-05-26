import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshop/consts/consts.dart';
import 'package:flapshop/controllers/home_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = 0.obs;
  var addresscontroller = TextEditingController();
  var citycontroller = TextEditingController();
  var statecontroller = TextEditingController();
  var postalcodecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var paymentIndex = 0.obs;
  late dynamic productSnapshot;
  var prodcut = [];
  var placingOrder = false.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  getProductDetails() {
    prodcut.clear();
    for (int i = 0; i < productSnapshot.length; i++) {
      prodcut.add({
        'color': productSnapshot[i]['color'],
        'image': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
        'tprice': productSnapshot[i]['tprice'],
        'vender_id': productSnapshot[i]['vender_id']
      });
    }
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();
    await FirebaseFirestore.instance.collection(ordersCollection).doc().set(
      {
        'order_by': currentUser!.uid,
        'order_by_name': Get.find<HomeController>().username,
        'order_by_email': currentUser!.email,
        'order_by_address': addresscontroller.text,
        'order_by_state': statecontroller.text,
        'order_by_city': citycontroller.text,
        'order_by_phone': phonecontroller.text,
        'order_by_postalcode': postalcodecontroller.text,
        'shipping_method': "Home Delivery",
        'payment_method': orderPaymentMethod,
        'order_placed': true,
        'order_confirmed': false,
        'order_delivered': false,
        'order_on_delivery': false,
        'order_code': '',
        'total_amount': totalAmount,
        'orders': FieldValue.arrayUnion(prodcut),
      },
    );
    placingOrder(false);
  }

  clearCart() {
    for (int i = 0; i < productSnapshot.length; i++) {
      FirebaseFirestore.instance
          .collection(cartCollection)
          .doc(productSnapshot[i].id)
          .delete();
    }
  }
}
