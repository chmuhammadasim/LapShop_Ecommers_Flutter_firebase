import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshop/consts/firebase_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var username = '';
  var searchController = TextEditingController();

  getUserName() async {
    var n = await FirebaseFirestore.instance
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }
}
