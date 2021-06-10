import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  // Variaveis
  Rx<UserModel> user = UserModel().obs;
  RxString userName = "".obs;
  //

  @override
  void onInit() {
    super.onInit();
    setUser();
  }

  setUser() {
    user = AuthService.to.user;
  }

  logout() async {
    await AuthService.to.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
