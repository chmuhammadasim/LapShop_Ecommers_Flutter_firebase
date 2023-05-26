import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/controller/homecontroller.dart';
import 'package:flapshopadmin/views/home_Screen/home_Screen.dart';
import 'package:flapshopadmin/views/order_screen/order_screen.dart';
import 'package:flapshopadmin/views/product_Screen/product_screen.dart';
import 'package:flapshopadmin/views/profile_screen/profile_Screen.dart';

import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreen = [
      const HomeScreen(),
      const ProductScreen(),
      const OrderScreen(),
      const ProfileScreen(),
    ];
    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(imgProduct, width: 24, color: darkGrey),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(icorders, width: 24, color: darkGrey),
          label: order),
      BottomNavigationBarItem(
          icon: Image.asset(icgeneralsetting, width: 24, color: darkGrey),
          label: settings)
    ];
    return Scaffold(
      backgroundColor: white,
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: navScreen.elementAt(controller.navIndex.value),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          items: bottomNavbar,
          currentIndex: controller.navIndex.value,
        ),
      ),
    );
  }
}
