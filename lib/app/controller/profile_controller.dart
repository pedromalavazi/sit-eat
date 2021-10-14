import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/image_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  ImageService _imageService = ImageService();

  Rx<UserModel> user = UserModel().obs;
  RxString userImage = "".obs;

  @override
  void onInit() async {
    user = AuthService.to.user;
    userImage.value =
        await _imageService.downloadUserUrl(AuthService.to.user.value.image);
    super.onInit();
  }

  logout() async {
    await AuthService.to.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
