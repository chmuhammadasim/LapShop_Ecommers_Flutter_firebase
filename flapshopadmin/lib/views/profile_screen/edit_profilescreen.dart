import 'dart:io';

import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/controller/profile_controller.dart';
import 'package:flapshopadmin/views/widget/custom_textfield.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.namecontroller.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          actions: [
            controller.isLoading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      red,
                    ),
                  )
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      if (controller.profileImagePath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink =
                            controller.snapshotdata['ImgURL'];
                      }
                      if (controller.snapshotdata['password'] ==
                          controller.oldpasswordcontroller.text) {
                        await controller.changeAuthPassword(
                          email: controller.snapshotdata['email'],
                          password: controller.oldpasswordcontroller.text,
                          newpassword: controller.newpasswordcontroller.text,
                        );
                        await controller.updateprofile(
                          imgURL: controller.profileImageLink,
                          name: controller.namecontroller.text,
                          password: controller.newpasswordcontroller.text,
                        );
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Updated!");
                      } else if (controller
                              .oldpasswordcontroller.text.isEmptyOrNull &&
                          controller.newpasswordcontroller.text.isEmptyOrNull) {
                        await controller.updateprofile(
                          imgURL: controller.profileImageLink,
                          name: controller.namecontroller.text,
                          password: controller.snapshotdata['password'],
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Error Occured!");
                        controller.isLoading(false);
                      }
                    },
                    child: normalText(text: "Save", color: fontGrey),
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
              controller.snapshotdata['imgURL'] ==
                      controller.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProduct,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : controller.snapshotdata['imgURL'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(
                          controller.snapshotdata['imgURL'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              //Image.asset(
              //  imgProduct,
              //  width: 150,
              //).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: white),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: changeImage, color: fontGrey),
              ),
              10.heightBox,
              const Divider(
                color: white,
              ),
              boldText(text: "Chnage Your Password"),
              customTextField(
                  label: name,
                  hint: "baba yaga",
                  controller: controller.namecontroller),
              10.heightBox,
              customTextField(
                  label: password,
                  hint: passwordhint,
                  controller: controller.oldpasswordcontroller),
              10.heightBox,
              customTextField(
                  label: confirmPassword,
                  hint: passwordhint,
                  controller: controller.newpasswordcontroller),
            ],
          ),
        ),
      ),
    );
  }
}
