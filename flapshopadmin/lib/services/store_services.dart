import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshopadmin/const/const.dart';

class StoreService {
  static getProfile(uid) {
    return FirebaseFirestore.instance
        .collection(vendorsCollection)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessage(uid) {
    return FirebaseFirestore.instance
        .collection(chatsCollection)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  static getOrders(uid) {
    return FirebaseFirestore.instance
        .collection(ordersCollection)
        .where('vender_id', isEqualTo: uid)
        .snapshots();
  }

  static getProducts(uid) {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .where('vender_id', isEqualTo: uid)
        .snapshots();
  }

  static getPolpularProduct(uid) {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .where('vender_id', isEqualTo: uid)
        .orderBy('p_wishlist'.length);
  }

  static getChatMessages(docId) {
    return FirebaseFirestore.instance
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy(
          'created_on',
          descending: false,
        )
        .snapshots();
  }
}
