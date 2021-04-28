import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:sit_eat/app/controller/navigation_controller.dart';
import 'package:sit_eat/app/ui/android/home/home_page.dart';
import 'package:sit_eat/app/ui/android/reservation/reservation_page.dart';

class NavigationPage extends StatelessWidget {
  final NavigationController _navigationController =
      Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => PageView(
          children: [
            HomePage(),
            ReservationPage(),
          ],
          onPageChanged: _navigationController.onPageChanged,
          controller: _navigationController.controller.value,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.qr_code),
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
                title: Text("Home")),
            BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.schedule_outlined,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.schedule,
                  color: Colors.red,
                ),
                title: Text("Reservas")),
          ],
        ),
      ),
    );
  }
}
