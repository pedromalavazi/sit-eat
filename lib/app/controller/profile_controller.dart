import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';

class ProfileController extends GetxController {
  final UserModel user;
  final UserModel email;
  final UserModel phone;

  ProfileController(
    this.user, 
    this.email, 
    this.phone
    );

  RxString userName = "".obs;
  RxString userEmail = "".obs;
  RxString userPhone = "".obs;


  @override
  void onReady() {
    setUser(user);
    super.onReady();

    setEmail(email);
    super.onReady();

    setNumber(phone);
    super.onReady();
  }

  setUser(UserModel user) {
    user = user;
    userName.value = user.name;
  }

  setEmail(UserModel email) {
    email = email;
    userEmail.value = user.email;
  }

  setNumber(UserModel phone) {
    phone = phone;
    userPhone.value = user.phoneNumber;
  }


}
