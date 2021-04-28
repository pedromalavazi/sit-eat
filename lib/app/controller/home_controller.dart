import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sit_eat/app/data/model/user_model.dart';

class HomeController extends GetxController {
  GetStorage box = GetStorage('sit_eat');
  UserModel user = UserModel();
  RxString userName = "".obs;

  @override
  void onInit() {
    recoveryUser();
    super.onInit();
  }

  void recoveryUser() {
    if (box.hasData("auth")) {
      setUser(UserModel(
        id: box.read("auth")["id"],
        email: box.read("auth")["email"],
        name: box.read("auth")["name"],
        phoneNumber: box.read("auth")["phoneNumber"],
      ));
    }
  }

  setUser(UserModel user) {
    user = user;
    userName.value = user.name;
  }
}
