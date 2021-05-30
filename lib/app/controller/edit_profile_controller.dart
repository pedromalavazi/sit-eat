import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/user_service.dart';

class EditProfileController extends GetxController {
  GetStorage box = GetStorage('sit_eat');
  UserModel currentUser = AuthService.to.user.value;
  RxString userName = "".obs;
  UserModel user = UserModel();

  final UserService _userService = UserService();

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneNumberTextController =
      TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  @override
  void onInit() {
    setObsUser();
    super.onInit();
  }

  void setObsUser() {
    user = currentUser;
    userName.value = currentUser.name;
    nameTextController.text = currentUser.name;
    phoneNumberTextController.text = currentUser.phoneNumber;
  }

  void save() async {
    UserModel userToUpdate = user;
    userToUpdate.name = nameTextController.text;
    userToUpdate.phoneNumber = phoneNumberTextController.text;

    await _userService.updateUser(
      user,
      passwordTextController.text.trim(),
      confirmPasswordTextController.text.trim(),
    );
  }

  void back() {
    Get.back();
  }
}
