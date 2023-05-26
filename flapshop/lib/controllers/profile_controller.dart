import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flapshop/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImagePath = ''.obs;
  var profileImageLink = '';
  var isLoading = false.obs;
  var namecontroller = TextEditingController();
  var newpasswordcontroller = TextEditingController();
  var oldpasswordcontroller = TextEditingController();
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

  updateprofile({name, password, imgUrl}) async {
    var store = FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(currentUser!.uid);
    await store.set(
        {
          'name': name,
          'password': password,
          'profileImage': imgUrl,
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
}
