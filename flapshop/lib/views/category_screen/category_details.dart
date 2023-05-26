import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshop/controllers/product_controller.dart';
import 'package:flapshop/services/firestore_services.dart';
import 'package:flapshop/views/category_screen/item_details.dart';
import 'package:flapshop/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flapshop/consts/consts.dart';
import 'package:get/get.dart';

class CategoriesDeatils extends StatefulWidget {
  final String? title;
  const CategoriesDeatils({super.key, required this.title});

  @override
  State<CategoriesDeatils> createState() => _CategoriesDeatilsState();
}

class _CategoriesDeatilsState extends State<CategoriesDeatils> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FireStoreService.getSubCategoryProducts(title);
    } else {
      productMethod = FireStoreService.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: widget.title!.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  controller.subcat.length,
                  (index) => "${controller.subcat[index]}"
                      .text
                      .size(16)
                      .fontFamily(bold)
                      .color(darkFontGrey)
                      .makeCentered()
                      .box
                      .white
                      .rounded
                      .size(150, 60)
                      .margin(
                        const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                      )
                      .make()
                      .onTap(
                    () {
                      switchCategory("${controller.subcat[index]}");
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            20.heightBox,
            StreamBuilder(
                stream: productMethod,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          redColor,
                        ),
                      ),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: "No products available".text.white.make(),
                    );
                  } else {
                    var data = snapshot.data!.docs;
                    return Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_images'][0],
                                  width: 200,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                "${data[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${data[index]['p_price']}"
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
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .roundedSM
                                .outerShadowSm
                                .padding(const EdgeInsets.all(12))
                                .make()
                                .onTap(() {
                              controller.checkIfFav(data[index]);
                              Get.to(() => ItemDetail(
                                    title: "${data[index]['p_name']}",
                                    data: data[index],
                                  ));
                            });
                          }),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
