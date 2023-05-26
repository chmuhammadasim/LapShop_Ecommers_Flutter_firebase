import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshopadmin/const/const.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var confirmed = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;
  var orders = [];
  getOrders(data) {
    orders.clear();
    for (var i in data['orders']) {
      if (i['vender_id'] == currentUser!.uid) {
        orders.add(i);
      }
    }
  }

  changeStatus({title, status, docId}) async {
    var store =
        FirebaseFirestore.instance.collection(ordersCollection).doc(docId);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
