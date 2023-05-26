import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/controller/profile_controller.dart';
import 'package:flapshopadmin/views/widget/custom_textfield.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:get/get.dart';

class ShopSettingScreen extends StatelessWidget {
  const ShopSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          actions: [
            controller.isLoading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(red),
                  )
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopname: controller.shopnamecontroller.text,
                        shopaddress: controller.shopaddresscontroller.text,
                        shopmobile: controller.shopmobilecontroller.text,
                        shopwebsite: controller.shopwebsitecontroller.text,
                        shopdescription:
                            controller.shopdescriptioncontroller.text,
                      );
                      VxToast.show(context, msg: "Shop Updated");
                    },
                    child: normalText(text: "Save"),
                  ),
          ],
          title: boldText(
            text: editProfile,
            color: darkGrey,
            size: 18.0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                label: name,
                hint: namehint,
                controller: controller.shopnamecontroller,
              ),
              15.heightBox,
              customTextField(
                label: address,
                hint: addresshint,
                controller: controller.shopaddresscontroller,
              ),
              15.heightBox,
              customTextField(
                label: mobile,
                hint: shopmobileHint,
                controller: controller.shopmobilecontroller,
              ),
              15.heightBox,
              customTextField(
                label: webiste,
                hint: shopWebsiteHint,
                controller: controller.shopwebsitecontroller,
              ),
              15.heightBox,
              customTextField(
                isDescription: true,
                label: description,
                hint: shopdeshint,
                controller: controller.shopdescriptioncontroller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
