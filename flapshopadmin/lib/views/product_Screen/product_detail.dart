import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';
import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  final dynamic data;
  const ProductDetail({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: fontGrey,
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(
          text: "${data['p_name']}",
          color: fontGrey,
          size: 18.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                autoPlay: true,
                height: 350,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemCount: data['p_images'].length,
                itemBuilder: ((context, index) {
                  return Image.network(
                    data['p_images'][index],
                    //"data['p_images'][index]",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),
              ),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(
                        text: "${data['p_name']}", color: fontGrey, size: 16.0),
                    10.heightBox,
                    Row(
                      children: [
                        boldText(
                          text: "${data['p_category']}",
                          color: fontGrey,
                          size: 16.0,
                        ),
                        20.widthBox,
                        normalText(
                          text: "${data['p_subcategory']}",
                          color: fontGrey,
                          size: 16.0,
                        ),
                      ],
                    ),
                    20.heightBox,
                    const Divider(),
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                      stepInt: false,
                    ),
                    10.heightBox,
                    boldText(
                        text: "${data['p_price']}", color: red, size: 18.0),
                    20.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: normalText(text: "color", color: fontGrey),
                            ),
                            Row(
                              children: List.generate(
                                data['p_colors'].length,
                                (index) => VxBox()
                                    .size(40, 40)
                                    .roundedFull
                                    .color(Color(data['p_colors'][index]))
                                    .margin(
                                      const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                    )
                                    .make()
                                    .onTap(() {}),
                              ),
                            ),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                        10.heightBox,
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  normalText(text: "Quantity", color: fontGrey),
                            ),
                            normalText(
                                text: "${data['p_quantity']}", color: fontGrey),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                      ],
                    ),
                    const Divider(),
                    10.heightBox,
                    boldText(text: description, color: fontGrey, size: 16.0),
                    10.heightBox,
                    normalText(
                        text: "${data['p_description']}", color: darkGrey),
                    10.heightBox,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
