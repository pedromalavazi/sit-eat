import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavigationController extends GetxController {
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
