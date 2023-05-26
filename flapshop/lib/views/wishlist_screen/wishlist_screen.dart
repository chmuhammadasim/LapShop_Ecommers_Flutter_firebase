import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshop/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:flapshop/consts/consts.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "My WishList"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
          stream: FireStoreService.getWishList(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "NO WishList yet".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      leading: Image.network(
                        "${data[index]['p_images'][0]}",
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      title: "${data[index]['p_name']})"
                          .text
                          .fontFamily(semibold)
                          .size(16)
                          .make(),
                      subtitle: "${data[index]['p_price']}"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .size(14)
                          .color(fontGrey)
                          .make(),
                      trailing: const Icon(
                        Icons.favorite,
                        color: redColor,
                      ).onTap(
                        () async {
                          await FirebaseFirestore.instance
                              .collection(productsCollection)
                              .doc(data[index].id)
                              .set({
                            'p_wishlist':
                                FieldValue.arrayRemove([currentUser!.uid])
                          }, SetOptions(merge: true));
                        },
                      ),
                    );
                  });
            }
          },
        ));
  }
}
