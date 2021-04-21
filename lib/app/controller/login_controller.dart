import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
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

  void register() async {
    await loginRepository.createUserWithEmailAndPassword(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
      nameTextController.text.trim(),
    );

    Get.back();
  }

  void login() async {
    UserFirebaseModel user = await loginRepository.signInWithEmailAndPassword(
      emailTextController.text.trim(),
      passwordTextController.text,
    );

    if (user != null) {
      Get.offAllNamed(Routes.HOME, arguments: user);
    }
  }
}
