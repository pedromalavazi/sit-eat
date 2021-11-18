import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:sit_eat/app/controller/home_controller.dart';
import 'package:sit_eat/app/controller/navigation_controller.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:sit_eat/app/ui/android/home/home_page.dart';
import 'package:sit_eat/app/ui/android/menu/menu_page.dart';
import 'package:sit_eat/app/ui/android/menu/orders_page.dart';
import 'package:sit_eat/app/ui/android/profile/profile_page.dart';
import 'package:sit_eat/app/ui/android/reservation/reservation_page.dart';

class NavigationPage extends GetView<NavigationController> {
  final NavigationController _navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => PageView(
          children: !_navigationController.isUserSitting()
              ? [
                  // Usuário esperando mesa
                  HomePage(),
                  ReservationPage(),
                  ProfilePage(),
                ]
              : [
                  // Usuário sentado na mesa
                  MenuPage(),
                  OrdersPage(),
                  ReservationPage(),
                  ProfilePage(),
                ],
          onPageChanged: _navigationController.onPageChanged,
          controller: _navigationController.controller.value,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<HomeController>().scanQrCode();
          //Get.toNamed(Routes.RESTAURANT_MENU);
          //Get.toNamed(Routes.RESTAURANT_ORDERS);
          //Get.toNamed(Routes.RESTAURANT_PAYMENT);
        },
        child: Icon(Icons.qr_code_scanner),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Obx(
        () => BubbleBottomBar(
          hasNotch: true,
          fabLocation: BubbleBottomBarFabLocation.end,
          opacity: .2,
          currentIndex: _navigationController.page.value,
          onTap: (index) {
            _navigationController.redirectTo(index);
          },
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 8,
          items: <BubbleBottomBarItem>[
            if (!_navigationController.userIsSitting.value)
              BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                title: Text("Home"),
              ),
            if (_navigationController.userIsSitting.value)
              BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.menu_book_rounded,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.menu_book_rounded,
                  color: Colors.red,
                ),
                title: Text("Menu"),
              ),
            if (_navigationController.userIsSitting.value)
              BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.pending_actions_outlined,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.pending_actions_outlined,
                  color: Colors.red,
                ),
                title: Text("Pedidos"),
              ),
            BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.schedule_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.schedule_outlined,
                color: Colors.red,
              ),
              title: Text("Reservas"),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.person_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.person_outlined,
                color: Colors.red,
              ),
              title: Text("Perfil"),
            ),
          ],
        ),
      ),
    );
  }
}
