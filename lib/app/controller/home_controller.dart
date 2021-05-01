import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';

class HomeController extends GetxController {
  final UserModel user;
  HomeController(this.user);
  RxString userName = "".obs;

  @override
  void onReady() {
    setUser(user);
    super.onReady();
  }

  setUser(UserModel user) {
    user = user;
    userName.value = user.name;
  }
}
