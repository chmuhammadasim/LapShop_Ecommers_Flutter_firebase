import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flapshopadmin/const/const.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotdata;
  var profileImagePath = ''.obs;
  var profileImageLink = '';
  var isLoading = false.obs;
  var namecontroller = TextEditingController();
  var newpasswordcontroller = TextEditingController();
  var oldpasswordcontroller = TextEditingController();
  var shopnamecontroller = TextEditingController();
  var shopaddresscontroller = TextEditingController();
  var shopmobilecontroller = TextEditingController();
  var shopwebsitecontroller = TextEditingController();
  var shopdescriptioncontroller = TextEditingController();
  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (img == null) {
        return;
      }
      profileImagePath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var fileName = basename(profileImagePath.value);
    var destination = 'images/${currentUser!.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateprofile({name, password, imgURL}) async {
    var store = FirebaseFirestore.instance
        .collection(vendorsCollection)
        .doc(currentUser!.uid);
    await store.set(
        {
          'name': name,
          'password': password,
          'imgURL': imgURL,
        },
        SetOptions(
          merge: true,
        ));
    isLoading(false);
  }

  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((error) {
      print(error.toString());
    });
  }

  updateShop(
      {shopname, shopaddress, shopmobile, shopwebsite, shopdescription}) async {
    var store = FirebaseFirestore.instance
        .collection(vendorsCollection)
        .doc(currentUser!.uid);
    await store.set(
      {
        'shop_name': shopname,
        'shop_address': shopaddress,
        'shop_mobile': shopmobile,
        'shop_website': shopwebsite,
        'shop_description': shopdescription,
      },
      SetOptions(merge: true),
    );
    isLoading(false);
  }
}
