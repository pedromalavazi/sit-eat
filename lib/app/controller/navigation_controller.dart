import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/ui/android/home/home_page.dart';
import 'package:sit_eat/app/ui/android/reservation/reservation_page.dart';

class NavigationController extends GetxController {
  int currentIndex = 0;
  final UserModel user = Get.arguments;

  PageController pageController = PageController();
  List<Widget> screens = [HomePage(), ReservationPage()];

  void changePage(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
  }
}
