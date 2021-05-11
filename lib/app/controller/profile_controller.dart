import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/login_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  ProfileController(this.user);
  LoginService _loginService = LoginService();

  // Variaveis
  final UserModel user;
  RxString userName = "".obs;
  //

  @override
  void onReady() {
    setUser(user);
    super.onReady();
  }

  setUser(UserModel user) {
    user = user;
    userName.value = user.name;
  }

  void logOut() {
    _loginService.logOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
