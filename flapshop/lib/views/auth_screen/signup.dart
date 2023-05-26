import 'package:flapshop/consts/consts.dart';
import 'package:flapshop/controllers/auth_controller.dart';
import 'package:flapshop/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          appLogoWidget(),
          10.heightBox,
          "SignUp to $appname".text.fontFamily(bold).white.size(22).make(),
          10.heightBox,
          Obx(
            () => Column(
              children: [
                customTextField(
                  hint: nameHint,
                  title: name,
                  controller: nameController,
                  isPass: false,
                ),
                customTextField(
                  hint: emailHint,
                  title: email,
                  controller: emailController,
                  isPass: false,
                ),
                customTextField(
                  hint: passwordHint,
                  title: password,
                  controller: passwordController,
                  isPass: true,
                ),
                customTextField(
                  hint: passwordHint,
                  title: retypepassword,
                  controller: repasswordController,
                  isPass: true,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: forgetPassword.text.color(redColor).make())),
                Row(
                  children: [
                    Checkbox(
                        checkColor: redColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        }),
                    10.heightBox,
                    Expanded(
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            )),
                        TextSpan(
                            text: termsandconditions,
                            style: TextStyle(
                              fontFamily: bold,
                              color: redColor,
                            )),
                        TextSpan(
                            text: " & ",
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey,
                            )),
                        TextSpan(
                            text: privacypolicy,
                            style: TextStyle(
                              fontFamily: bold,
                              color: redColor,
                            )),
                      ])),
                    )
                  ],
                ),
                5.heightBox,
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : ourButton(
                        color: isCheck == true ? lightGrey : blackpure,
                        title: signup,
                        textColor: whiteColor,
                        onPress: () async {
                          if (isCheck != false) {
                            controller.isloading(true);
                            try {
                              await controller
                                  .signupMethod(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                              )
                                  .then((value) {
                                return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                );
                              }).then((value) {
                                VxToast.show(context, msg: "SignIn Successful");
                                Get.offAll(() => const Home());
                              });
                            } catch (e) {
                              controller.isloading(false);
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                            }
                          }
                        },
                      ).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alreadyhaveaccount.text.color(fontGrey).make(),
                    login.text.color(redColor).make().onTap(() {
                      Get.back();
                    }),
                  ],
                ),
              ],
            )
                .box
                .color(Colors.grey)
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ),
        ],
      )),
    ));
  }
}
