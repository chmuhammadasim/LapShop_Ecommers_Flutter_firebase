import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshop/consts/consts.dart';

class FireStoreService {
  ////get users data
  static getUser(uid) {
    return FirebaseFirestore.instance
        .collection(usersCollection)
        .where('id', isEqualTo: uid);
  }

  static getProducts(category) {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getCart(uid) {
    return FirebaseFirestore.instance
        .collection(cartCollection)
        .where('addedBy', isEqualTo: uid)
        .snapshots();
  }

  static deleteDocument(docId) {
    return FirebaseFirestore.instance
        .collection(cartCollection)
        .doc(docId)
        .delete();
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

  static getALLOrder() {
    return FirebaseFirestore.instance
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishList() {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return FirebaseFirestore.instance
        .collection(chatsCollection)
        .where(
          'fromId',
          isEqualTo: currentUser!.uid,
        )
        .snapshots();
  }

  static getCount() async {
    var res = Future.wait(
      [
        FirebaseFirestore.instance
            .collection(cartCollection)
            .where(
              'addedBy',
              isEqualTo: currentUser!.uid,
            )
            .get()
            .then(
          (value) {
            return value.docs.length;
          },
        ),
        FirebaseFirestore.instance
            .collection(productsCollection)
            .where(
              'p_wishlist',
              isEqualTo: currentUser!.uid,
            )
            .get()
            .then(
          (value) {
            return value.docs.length;
          },
        ),
        FirebaseFirestore.instance
            .collection(ordersCollection)
            .where(
              'order_by',
              isEqualTo: currentUser!.uid,
            )
            .get()
            .then(
          (value) {
            return value.docs.length;
          },
        ),
      ],
    );
    return res;
  }

  static allProducts() {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .snapshots();
  }

  static featuredProducts() {
    return FirebaseFirestore.instance
        .collection(productsCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

  static searchProducts(title) {
    return FirebaseFirestore.instance.collection(productsCollection).get();
  }

  static getSubCategoryProducts(title) {
    FirebaseFirestore.instance
        .collection(productsCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }
}

final ref = FirebaseFirestore.instance.collection(usersCollection);
