import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/image_service.dart';
import 'package:sit_eat/app/data/services/user_service.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class EditProfileController extends GetxController {
  GetStorage box = GetStorage('sit_eat');
  Rx<UserModel> user = AuthService.to.user;
  RxString userName = "".obs;

  final UserService _userService = UserService();
  final ImageService _imageService = ImageService();
  final UtilService _util = UtilService();

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneNumberTextController =
      TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  Rx<XFile> image = null.obs;
  RxString userImage = "".obs;
  bool needToUpdateImage = false;

  @override
  Future<void> onInit() async {
    await setObsUser();
    await loadUserImage();
    super.onInit();
  }

  Future<void> setObsUser() async {
    nameTextController.text = user.value.name;
    phoneNumberTextController.text = user.value.phoneNumber;
  }

  void save() async {
    _util.showLoader();
    UserModel userToUpdate = user.value;
    userToUpdate.name = nameTextController.text;
    userToUpdate.phoneNumber = phoneNumberTextController.text;
    userToUpdate.image = image.value.name;

    if (needToUpdateImage) {
      await _imageService.uploadUserImage(image.value);
    }

    await _userService.updateUser(
      userToUpdate,
      passwordTextController.text.trim(),
      confirmPasswordTextController.text.trim(),
    );

    Get.back();
  }

  /// Get from gallery
  Future pickImage(ImageSource imageSource) async {
    var imageFile = await ImagePicker().pickImage(source: imageSource);

    if (imageFile is XFile) {
      image = imageFile.obs;
      userImage.value = image.value.path;
      needToUpdateImage = true;
    }

    Get.back();
  }

  Future<void> loadUserImage() async {
    userImage.value =
        await _imageService.downloadUserUrl(AuthService.to.user.value.image);
  }
}
