import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';

class HomeController extends GetxController {
  UserModel user = UserModel();

  RxString userName = "".obs;
  setUser(UserModel user) {
    user = user;
    userName.value = user.name;
  }
}
