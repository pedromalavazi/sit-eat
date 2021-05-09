import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/repository/login_repository.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final UserModel user;
  ProfileController(this.user);

  LoginRepository _loginRepository = LoginRepository();

  // Variaveis
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
    _loginRepository.logOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
