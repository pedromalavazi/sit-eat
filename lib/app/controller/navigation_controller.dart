import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/data/model/enum/login_status_enum.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';

class NavigationController extends GetxController {
  RxInt page = 0.obs;
  Rx<PageController> controller = PageController().obs;
  AuthService _authService = AuthService();
  RxBool userIsSitting = false.obs;

  @override
  void onInit() {
    listenUserUpdates();
    super.onInit();
  }

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

  listenUserUpdates() {
    _authService.userListener(AuthService.to.user.value.id).listen((user) {
      if (user.status == LoginStatus.IN) {
        userIsSitting.value = true;
      } else {
        userIsSitting.value = false;
      }
    });
  }

  bool isUserSitting() {
    return userIsSitting.value == true;
  }
}
