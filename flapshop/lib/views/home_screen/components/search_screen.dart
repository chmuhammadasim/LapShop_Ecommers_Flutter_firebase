import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshop/consts/consts.dart';
import 'package:flapshop/services/firestore_services.dart';
import 'package:flapshop/views/category_screen/item_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.make(),
      ),
      body: FutureBuilder(
        future: FireStoreService.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No products found"
                  .text
                  .fontFamily(semibold)
                  .color(darkFontGrey)
                  .make(),
            );
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where(
                  (element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()),
                )
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 300,
                ),
                children: filtered
                    .mapIndexed(
                      (currentValue, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            filtered[index]['p_images'][0],
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          const Spacer(),
                          "${data[index]['p_name']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          10.heightBox,
                          "${filtered[index]['p_price']}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(16)
                              .make(),
                        ],
                      )
                          .box
                          .white
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .roundedSM
                          .padding(const EdgeInsets.all(12))
                          .make()
                          .onTap(
                        () {
                          Get.to(
                            () => ItemDetail(
                              title: "${filtered[index]['p_name']}",
                              data: filtered[index],
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
