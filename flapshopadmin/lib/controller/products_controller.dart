import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flapshopadmin/controller/homecontroller.dart';
import 'package:path/path.dart';
import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var pnamecontroller = TextEditingController();
  var pdescontroller = TextEditingController();
  var ppricecontroller = TextEditingController();
  var pquantitycontroller = TextEditingController();

  var categorylist = <String>[].obs;
  var subcategorylist = <String>[].obs;
  var pimageslinks = [];
  List<Category> category = [];
  var pimageslist = RxList<dynamic>.generate(3, (index) => null);
  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedcolorindex = 0.obs;

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categorylist.clear();
    for (var item in category) {
      categorylist.add(item.name);
    }
  }

  populateSubCategoryList(cat) {
    subcategorylist.clear();
    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subCategory.length; i++) {
      subcategorylist.add(data.first.subCategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pimageslist[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage() async {
    pimageslinks.clear();
    for (var i in pimageslist) {
      if (i != null) {
        var fileName = basename(i.path);
        var destination = 'images/venders/${currentUser!.uid}/$fileName';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(i);
        var n = await ref.getDownloadURL();
        pimageslinks.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = FirebaseFirestore.instance.collection(productsCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryvalue.value,
      'p_subcategory': subcategoryvalue.value,
      'p_colors': FieldValue.arrayUnion([
        Colors.grey.value,
        Colors.black.value,
      ]),
      'p_images': FieldValue.arrayUnion(pimageslinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_description': pdescontroller.text,
      'p_name': pnamecontroller.text,
      'p_price': ppricecontroller.text,
      'p_quantity': pquantitycontroller.text,
      'p_seller': Get.find<HomeController>().username,
      'p_rating': "5.0",
      'vender_id': currentUser!.uid,
      'featured_id': '',
    });
    isLoading(false);
    VxToast.show(context, msg: "Product Uploaded");
  }

  addFeatured(docId) async {
    await FirebaseFirestore.instance
        .collection(productsCollection)
        .doc(docId)
        .set({
      'featured_id': currentUser!.uid,
      'is_featured': true,
    }, SetOptions(merge: true));
  }

  removeFeatured(docId) async {
    await FirebaseFirestore.instance
        .collection(productsCollection)
        .doc(docId)
        .set({
      'featured_id': '',
      'is_featured': false,
    }, SetOptions(merge: true));
  }

  removeProduct(docId) async {
    await FirebaseFirestore.instance
        .collection(productsCollection)
        .doc(docId)
        .delete();
  }
}
