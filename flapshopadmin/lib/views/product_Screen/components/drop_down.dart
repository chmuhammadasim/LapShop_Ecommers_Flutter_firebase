import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/controller/products_controller.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:get/get.dart';

Widget productDropDown(
    hint, List<String> list, dropvalue, ProductController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: fontGrey),
        value: dropvalue.value == '' ? null : dropvalue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make(),
          );
        }).toList(),
        onChanged: (newValue) {
          if (hint == "category") {
            controller.subcategoryvalue.value = '';
            controller.populateSubCategoryList(newValue.toString());
          }
          dropvalue.value = newValue.toString();
        },
      ),
    )
        .box
        .white
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .roundedSM
        .make(),
  );
}
