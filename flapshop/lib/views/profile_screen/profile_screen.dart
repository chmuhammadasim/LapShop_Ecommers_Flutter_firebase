import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshop/consts/consts.dart';
import 'package:flapshop/controllers/auth_controller.dart';
import 'package:flapshop/controllers/profile_controller.dart';
import 'package:flapshop/views/auth_screen/login_screen.dart';
import 'package:flapshop/views/chat_screen/messaging_screen.dart';
import 'package:flapshop/views/orders_screen/orders_screen.dart';
import 'package:flapshop/views/profile_screen/edit_profilescreen.dart';
import 'package:flapshop/views/wishlist_screen/wishlist_screen.dart';
import 'package:flapshop/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/lists.dart';
import '../../services/firestore_services.dart';
import 'components/detail_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FireStoreService.getUser(currentUser!.uid).snapshots(),

          ///FireStoreService.getUser(currentUser!.uid).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        ),
                      ).onTap(() {
                        controller.namecontroller.text = data['name'];

                        Get.to(() => EditProfileScreen(data: data));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          data['profileImage'] == ''
                              ? Image.asset(
                                  imgProfile2,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['profileImage'],
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                5.heightBox,
                                "${data['email']}".text.white.make(),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: redColor,
                              ),
                            ),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signOutMethod(context: context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child:
                                logout.text.fontFamily(semibold).white.make(),
                          )
                        ],
                      ),
                    ),
                    20.heightBox,
                    FutureBuilder(
                      future: FireStoreService.getCount(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            ),
                          );
                        } else {
                          var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailButton(
                                count: countData[0].toString(),
                                title: "In your Cart",
                                width: context.screenWidth / 3.4,
                              ),
                              detailButton(
                                count: countData[1].toString(),
                                title: "In your WishList",
                                width: context.screenWidth / 3.4,
                              ),
                              detailButton(
                                count: countData[2].toString(),
                                title: "Your Orders",
                                width: context.screenWidth / 3.4,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    /* Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        detailButton(
                          count: "${data['cart_count']}",
                          title: "In your Cart",
                          width: context.screenWidth / 3.4,
                        ),
                        detailButton(
                          count: "${data['wishlist_count']}",
                          title: "In your WishList",
                          width: context.screenWidth / 3.4,
                        ),
                        detailButton(
                          count: "${data['order_count']}",
                          title: "Your Orders",
                          width: context.screenWidth / 3.4,
                        ),
                      ],
                    ), */
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profilebuttonlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const OrderScreen());
                                break;
                              case 1:
                                Get.to(() => const WishListScreen());
                                break;
                              case 2:
                                Get.to(() => const MessagesScreen());
                                break;
                              default:
                            }
                          },
                          leading: Image.asset(
                            profilebuttoniconlist[index],
                            width: 22,
                          ),
                          title: profilebuttonlist[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      },
                    )
                        .box
                        .white
                        .rounded
                        .shadowSm
                        .margin(const EdgeInsets.all(12))
                        .padding(
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                        )
                        .make()
                        .box
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
