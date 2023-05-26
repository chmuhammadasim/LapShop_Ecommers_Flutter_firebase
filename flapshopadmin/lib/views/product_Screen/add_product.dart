import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/controller/products_controller.dart';
import 'package:flapshopadmin/views/product_Screen/components/drop_down.dart';
import 'package:flapshopadmin/views/product_Screen/components/product_image.dart';
import 'package:flapshopadmin/views/widget/custom_textfield.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          actions: [
            controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(red),
                  ))
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.uploadImage();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(text: "Save", color: Colors.white),
                  ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: white,
            onPressed: () {
              Get.back();
            },
          ),
          title: boldText(
            text: "Add Product",
            color: white,
            size: 18.0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                customTextField(
                    hint: "eg. BMW",
                    label: "Product Name",
                    controller: controller.pnamecontroller),
                10.heightBox,
                customTextField(
                  hint: "lorem Ipsam et al.",
                  label: "Description",
                  isDescription: true,
                  controller: controller.pdescontroller,
                ),
                10.heightBox,
                customTextField(
                  hint: "\$100",
                  label: "Price",
                  controller: controller.ppricecontroller,
                ),
                10.heightBox,
                customTextField(
                  hint: "10",
                  label: "Quantity",
                  controller: controller.pquantitycontroller,
                ),
                10.heightBox,
                productDropDown("category", controller.categorylist,
                    controller.categoryvalue, controller),
                10.heightBox,
                productDropDown("subCategory", controller.subcategorylist,
                    controller.subcategoryvalue, controller),
                10.heightBox,
                const Divider(),
                boldText(text: "Choose Product Image", color: white),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => controller.pimageslist[index] != null
                          ? Image.file(
                              controller.pimageslist[index],
                              width: 100,
                            ).onTap(() {
                              controller.pickImage(index, context);
                            })
                          : productImage(
                              lable: "${index + 1}",
                            ).onTap(() {
                              controller.pickImage(index, context);
                            }),
                    ),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First Image Will Be Displayed",
                    color: Colors.white70),
                const Divider(),
                10.heightBox,
                boldText(text: "Choose Product Color", color: white),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(
                      3,
                      (index) => Stack(
                        alignment: Alignment.center,
                        children: [
                          VxBox()
                              .color(Vx.randomPrimaryColor)
                              .roundedFull
                              .size(50, 50)
                              .make()
                              .onTap(() {
                            controller.selectedcolorindex.value = index;
                          }),
                          controller.selectedcolorindex.value == index
                              ? const Icon(
                                  Icons.done,
                                  color: white,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
