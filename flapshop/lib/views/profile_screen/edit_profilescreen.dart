import 'dart:io';
import 'package:flapshop/controllers/profile_controller.dart';
import 'package:flapshop/widgets_common/bg_widget.dart';
import 'package:flapshop/widgets_common/custom_textfield.dart';
import 'package:flapshop/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flapshop/consts/consts.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          () => Column(
            children: [
              data['profileImage'] == controller.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['profileImage'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(
                          data['profileImage'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              const Divider(),
              20.heightBox,
              customTextField(
                controller: controller.namecontroller,
                hint: nameHint,
                title: name,
                isPass: false,
              ),
              10.heightBox,
              customTextField(
                controller: controller.oldpasswordcontroller,
                hint: passwordHint,
                title: oldpassword,
                isPass: true,
              ),
              10.heightBox,
              customTextField(
                controller: controller.newpasswordcontroller,
                hint: passwordHint,
                title: newpassword,
                isPass: true,
              ),
              20.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 40,
                      child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.isLoading(true);
                          if (controller.profileImagePath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['profileImage'];
                          }
                          if (data['password'] ==
                              controller.oldpasswordcontroller.text) {
                            await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldpasswordcontroller.text,
                              newpassword: controller.namecontroller.text,
                            );
                            await controller.updateprofile(
                              imgUrl: controller.profileImageLink,
                              name: controller.namecontroller.text,
                              password: controller.newpasswordcontroller.text,
                            );
                            VxToast.show(context, msg: "Updated!");
                          } else {
                            VxToast.show(context, msg: "Wrong Old Password!");
                            controller.isLoading(false);
                          }
                        },
                        textColor: whiteColor,
                        title: "Save",
                      ),
                    ),
            ],
          )
              .box
              .shadowSm
              .white
              .padding(
                const EdgeInsets.all(16),
              )
              .rounded
              .margin(
                const EdgeInsets.only(
                  top: 50,
                  left: 12,
                  right: 12,
                ),
              )
              .make(),
        ),
      ),
    );
  }
}
