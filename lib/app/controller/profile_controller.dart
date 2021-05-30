import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/login_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  LoginService _loginService = LoginService();

  // Variaveis
  Rx<UserModel> user = UserModel().obs;
  RxString userName = "".obs;
  //

  @override
  void onInit() {
    super.onInit();
    setUser();
  }

  setUser() {
    user = AuthService.to.user;
    //userName.value = AuthService.to.user.name ?? "";
  }

  void logOut() {
    _loginService.logOut();
    Get.offNamed(Routes.LOGIN);
  }
}
