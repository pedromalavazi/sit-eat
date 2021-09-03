import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/util_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final UtilService _util = UtilService();

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneNumberTextController =
      TextEditingController();

  @override
  void onInit() {
    isLogged();
    super.onInit();
  }

  void isLogged() async {
    if (await AuthService.to.verifyLoggedUser()) {
      Get.offAllNamed(Routes.NAVIGATION);
    }
  }

  void registerUser() async {
    _util.showLoader();
    bool success = await AuthService.to.createUser(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
      nameTextController.text,
      phoneNumberTextController.text,
    );

    if (success) Get.back();
  }

  void login() async {
    _util.showLoader();
    bool logged = await AuthService.to.login(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
    );
    if (logged) {
      Get.offAllNamed(Routes.NAVIGATION);
    }
  }

  void resetPassword() async {
    bool userExist = await AuthService.to.resetPassword(
      emailTextController.text.trim(),
    );
    if (!userExist) {
      emailTextController.text = "";
    }
  }
}
