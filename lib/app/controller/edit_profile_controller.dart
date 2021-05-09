import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/repository/login_repository.dart';
import 'package:sit_eat/app/data/repository/user_repository.dart';

class EditProfileController extends GetxController {
  GetStorage box = GetStorage('sit_eat');
  UserModel currentUser = Get.arguments;
  RxString userName = "".obs;
  UserModel user = UserModel();

  final UserRepository _userRepository = UserRepository();
  final LoginRepository _loginRepository = LoginRepository();

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneNumberTextController =
      TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  @override
  void onReady() {
    setObsUser();
    super.onReady();
  }

  void setObsUser() {
    user = currentUser;
    userName.value = currentUser.name;
    nameTextController.text = currentUser.name;
    phoneNumberTextController.text = currentUser.phoneNumber;
  }

  void save() async {
    String newPassword = "";
    UserModel userToUpdate = user;
    userToUpdate.name = nameTextController.text;
    userToUpdate.phoneNumber = phoneNumberTextController.text;

    if (!GetUtils.isNullOrBlank(passwordTextController.text.trim()) &&
        !GetUtils.isNullOrBlank(confirmPasswordTextController.text.trim())) {
      newPassword = passwordTextController.text.trim();
    }

    //Atualiza usuário logado e o da base do flutter
    var userUpdated =
        await _loginRepository.updateLoggedUser(userToUpdate, newPassword);
    if (userUpdated != null) {
      //Atualiza usuário na nossa base
      var updated = await _userRepository.updateUser(userToUpdate);

      if (updated) {
        user = userToUpdate;
        userName.value = userToUpdate.name;
      }
    }

    box.write("auth", user);
  }
}
