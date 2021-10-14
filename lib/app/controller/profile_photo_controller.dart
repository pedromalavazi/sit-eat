import 'package:get/get.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/image_service.dart';

class ProfilePhotoController extends GetxController {
  ImageService _imageService = ImageService();
  AuthService _authService = AuthService();

  RxString userImage = "".obs;

  @override
  void onInit() {
    listenUserUpdates();
    super.onInit();
  }

  listenUserUpdates() {
    _authService
        .userListener(AuthService.to.user.value.id)
        .listen((user) async {
      if (user.image != userImage.value) {
        await downloadUserUrl(user.image);
      }
    });
  }

  Future<String> downloadUserUrl(String image) async {
    userImage.value = await _imageService.downloadUserUrl(image);
    return userImage.value;
  }
}
