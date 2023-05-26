import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/controller/auth_controller.dart';
import 'package:flapshopadmin/controller/profile_controller.dart';
import 'package:flapshopadmin/services/store_services.dart';
import 'package:flapshopadmin/views/auth_Screen/login_screen.dart';
import 'package:flapshopadmin/views/messages_screen/messages_screen.dart';
import 'package:flapshopadmin/views/profile_screen/edit_profilescreen.dart';
import 'package:flapshopadmin/views/shop_settings/shop_settingscreen.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => EditProfileScreen(
                    username: controller.snapshotdata['name'],
                  ));
            },
            icon: const Icon(Icons.edit),
          ),
          TextButton(
            onPressed: () async {
              await Get.find<AuthController>().signOutMethod(context: context);
              Get.offAll(() => const LoginScreen());
            },
            child: normalText(text: logout),
          ),
        ],
        title: boldText(
          text: settings,
          color: Colors.white,
          size: 18.0,
        ),
      ),
      body: FutureBuilder(
        future: StoreService.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(red),
              ),
            );
          } else {
            controller.snapshotdata = snapshot.data!.docs[0];

            return Column(
              children: [
                ListTile(
                  leading: controller.snapshotdata['imgURL'] == ''
                      ? Image.asset(
                          imgProduct,
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.network(
                          controller.snapshotdata['imgURL'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
                  title: boldText(text: "${controller.snapshotdata['name']}"),
                  subtitle:
                      normalText(text: "${controller.snapshotdata['email']}"),
                ),
                10.heightBox,
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: List.generate(
                      profileButtonIcons.length,
                      (index) => ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const ShopSettingScreen());
                              break;
                            case 1:
                              Get.to(() => const MessageScreen());
                              break;
                          }
                        },
                        leading: Icon(
                          profileButtonIcons[index],
                          color: white,
                        ),
                        title: normalText(
                          text: profileButtonTitle[index],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
