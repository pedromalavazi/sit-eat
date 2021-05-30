import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class LoginController extends GetxController {
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
      Get.toNamed(Routes.NAVIGATION, arguments: true);
    }
  }

  void registerUser() async {
    showLoader();
    await AuthService.to.createUser(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
      nameTextController.text,
      phoneNumberTextController.text,
    );
    Get.toNamed(Routes.LOGIN);
  }

  void login() async {
    showLoader();
    await AuthService.to.login(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
    );
    Get.toNamed(Routes.NAVIGATION, arguments: true);
  }

  void resetPassword() async {
    bool userExist = await AuthService.to.resetPassword(
      emailTextController.text.trim(),
    );
    if (!userExist) {
      emailTextController.text = "";
    }
  }

  void logOut() async {
    await AuthService.to.logout();
    Get.offNamed(Routes.LOGIN);
  }

  showLoader() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
  }
}
