import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:sit_eat/app/controller/navigation_controller.dart';
import 'package:get/get.dart';

class NavigationPage extends StatelessWidget {
  final NavigationController _navigationController =
      Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _navigationController.pageController,
        children: _navigationController.screens,
        onPageChanged: _navigationController.changePage,
        physics: NeverScrollableScrollPhysics(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.qr_code),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: _navigationController.currentIndex,
        onTap: _navigationController.changePage,
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
    );
  }
}
