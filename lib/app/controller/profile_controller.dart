import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  Rx<UserModel> user = UserModel().obs;

  @override
  void onInit() {
    user = AuthService.to.user;
    super.onInit();
  }

  logout() async {
    await AuthService.to.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
