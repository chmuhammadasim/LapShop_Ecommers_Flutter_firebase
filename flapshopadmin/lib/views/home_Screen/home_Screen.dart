import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/services/store_services.dart';
import 'package:flapshopadmin/views/product_Screen/product_detail.dart';
import 'package:flapshopadmin/views/widget/dashboard_button.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: dashboard,
          color: darkGrey,
          size: 18.0,
        ),
      ),
      body: StreamBuilder(
          stream: StoreService.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(red),
              ));
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy((a, b) => b['p_wishlist'].length.compareTo(
                    a['p_wishlist'].length,
                  ));
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dashBoardButton(
                            context,
                            title: products,
                            count: 60,
                            icon: icproduct,
                          ),
                          dashBoardButton(context,
                              title: order, count: 15, icon: icorders),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dashBoardButton(
                            context,
                            title: rating,
                            count: 60,
                            icon: icstar,
                          ),
                          dashBoardButton(
                            context,
                            title: totalSells,
                            count: 15,
                            icon: icorders,
                          ),
                        ],
                      ),
                      10.heightBox,
                      const Divider(),
                      10.heightBox,
                      boldText(
                          text: popularproducts, color: fontGrey, size: 16.0),
                      20.heightBox,
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          data.length,
                          (index) => ListTile(
                            onTap: () {
                              Get.to(() => ProductDetail(
                                    data: data[index],
                                  ));
                            },
                            leading: Image.network(
                              data[index]['p_images'][0],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            title: boldText(
                              text: "${data[index]['p_name']}",
                              color: fontGrey,
                              size: 16.0,
                            ),
                            subtitle: normalText(
                                text: "${data[index]['p_price']}",
                                color: darkGrey),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
