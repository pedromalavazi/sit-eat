import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/controller/home_controller.dart';
import 'package:sit_eat/app/data/model/user_model.dart';

class NavigationController extends GetxController {
  UserModel user = Get.arguments;
  final HomeController _homeController = Get.put(HomeController());

  @override
  void onInit() {
    _homeController.setUser(user);
    super.onInit();
  }

  RxInt page = 0.obs;
  Rx<PageController> controller = PageController().obs;

  onPageChanged(input) {
    page.value = input;
  }

  redirectTo(int index) {
    if (controller.value.hasClients) {
      page.value = index;
      controller.value.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }
}
