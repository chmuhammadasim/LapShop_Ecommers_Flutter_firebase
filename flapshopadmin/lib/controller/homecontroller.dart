import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshopadmin/const/const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var navIndex = 0.obs;
  var username = '';
  @override
  void onInit() {
    super.onInit();
    getUsername();
  }

  getUsername() async {
    var n = await FirebaseFirestore.instance
        .collection(vendorsCollection)
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
