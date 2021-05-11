import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:sit_eat/app/data/services/login_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneNumberTextController = TextEditingController();

  @override
  void onReady() {
    isLogged();
    super.onReady();
  }

  void isLogged() {
    _loginService.verifyLoggedUser();
  }

  void registerUser() async {
    showLoader();

    _loginService.registerUser(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
      nameTextController.text,
      phoneNumberTextController.text,
    );

    Get.offAllNamed(Routes.LOGIN);
  }

  void login() async {
    showLoader();

    _loginService.login(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
    );
  }

  void resetPassword() async {
    bool userExist = await _loginService.resetPassword(
      emailTextController.text.trim(),
    );
    if (!userExist) {
      emailTextController.text = "";
    }
  }

  void logOut() {
    _loginService.logOut();
    Get.offAllNamed(Routes.LOGIN);
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
