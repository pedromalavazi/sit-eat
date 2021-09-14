import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/user_service.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class EditProfileController extends GetxController {
  GetStorage box = GetStorage('sit_eat');
  UserModel currentUser = AuthService.to.user.value;
  RxString userName = "".obs;
  UserModel user = UserModel();

  final UserService _userService = UserService();
  final UtilService _util = UtilService();

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneNumberTextController =
      TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  var selectedImagePath = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      Get.snackbar(
        'Error!',
        'Nenhuma imagem selecionada',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

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
    _util.showLoader();
    UserModel userToUpdate = user;
    userToUpdate.name = nameTextController.text;
    userToUpdate.phoneNumber = phoneNumberTextController.text;

    await _userService.updateUser(
      user,
      passwordTextController.text.trim(),
      confirmPasswordTextController.text.trim(),
    );
    Get.back();
  }
}
