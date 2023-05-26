import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/controller/products_controller.dart';
import 'package:flapshopadmin/services/store_services.dart';
import 'package:flapshopadmin/views/product_Screen/add_product.dart';
import 'package:flapshopadmin/views/product_Screen/product_detail.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async {
          await controller.getCategories();
          await controller.populateCategoryList();
          Get.to(() => const AddProduct());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: normalText(
              text: intl.DateFormat('EEE,MMM d, ' 'yy').format(DateTime.now()),
              color: purpleColor,
            ),
          ),
          10.widthBox,
        ],
        title: boldText(
          text: products,
          color: darkGrey,
          size: 18.0,
        ),
      ),
      body: StreamBuilder(
        stream: StoreService.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(red),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) => ListTile(
                      onTap: () {
                        Get.to(() => ProductDetail(
                              data: data[index],
                            ));
                      },
                      leading: Image.network(
                        "${data[index]['p_images'][0]}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: boldText(
                        text: "${data[index]['p_name']}",
                        color: fontGrey,
                        size: 16.0,
                      ),
                      subtitle: Row(
                        children: [
                          normalText(
                              text: "${data[index]['p_price']}",
                              color: darkGrey),
                          10.widthBox,
                          boldText(
                              text: data[index]['is_featured'] == true
                                  ? "Featured"
                                  : "",
                              color: green)
                        ],
                      ),
                      trailing: VxPopupMenu(
                          arrowSize: 0.0,
                          menuBuilder: () => Column(
                                children: List.generate(
                                  meunuPopupTitle.length,
                                  (i) => Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          meunuPopupIcons[i],
                                          color: data[index]['featured_id'] ==
                                                      currentUser!.uid &&
                                                  i == 0
                                              ? green
                                              : darkGrey,
                                        ),
                                        10.heightBox,
                                        normalText(
                                            text: data[index]['featured_id'] ==
                                                        currentUser!.uid &&
                                                    i == 0
                                                ? 'Removed Featured'
                                                : meunuPopupTitle[i],
                                            color: darkGrey)
                                      ],
                                    ).onTap(() {
                                      switch (i) {
                                        case 0:
                                          if (data[index]['is_featured'] ==
                                              true) {
                                            controller
                                                .removeFeatured(data[index].id);
                                          } else {
                                            controller
                                                .addFeatured(data[index].id);
                                          }
                                          break;
                                        case 1:
                                          break;
                                        case 2:
                                          controller
                                              .removeProduct(data[index].id);
                                          break;
                                        default:
                                      }
                                    }),
                                  ),
                                ),
                              ).box.white.rounded.width(200).make(),
                          clickType: VxClickType.singleClick,
                          child: const Icon(Icons.more_vert_rounded)),
                    )
                        .box
                        .outerShadowSm
                        .margin(const EdgeInsets.only(bottom: 5))
                        .make(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
