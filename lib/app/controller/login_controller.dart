import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/routes/app_pages.dart';
import 'package:sit_eat/app/data/model/user_firebase_model.dart';
import 'package:sit_eat/app/data/repository/login_repository.dart';
import 'package:sit_eat/app/data/repository/user_repository.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository = LoginRepository();
  final UserRepository userRepository = UserRepository();

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneNumberTextController =
      TextEditingController();
  GetStorage box = GetStorage('sit_eat');

  @override
  void onReady() {
    isLogged();
    super.onReady();
  }

  void isLogged() {
    if (box.hasData("auth")) {
      Get.offAllNamed(Routes.NAVIGATION);
    }
  }

  void register() async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    UserFirebaseModel firebaseUser =
        await loginRepository.createUserWithEmailAndPassword(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
      nameTextController.text.trim(),
    );

    if (firebaseUser != null) {
      userRepository.createUser(
        firebaseUser.id,
        firebaseUser.email,
        firebaseUser.name,
        phoneNumberTextController.text.trim(),
      );
    }

    Get.offAllNamed(Routes.LOGIN);
  }

  void login() async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    UserFirebaseModel firebaseUser =
        await loginRepository.signInWithEmailAndPassword(
      emailTextController.text.trim(),
      passwordTextController.text,
    );

    if (firebaseUser != null) {
      UserModel user = await userRepository.get(firebaseUser.id);
      box.write("auth", user);
      Get.offAllNamed(Routes.NAVIGATION, arguments: user);
    }
  }

  void logOut() {
    loginRepository.logOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
