import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sit_eat/app/data/model/user_firebase_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/repository/login_repository.dart';
import 'package:sit_eat/app/data/services/user_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class LoginService extends GetxService {
  GetStorage box = GetStorage('sit_eat');
  LoginRepository _loginRepository = LoginRepository();
  UserService _userService = UserService();

  Future<UserFirebaseModel> createUserWithEmailAndPassword(String email, String password, String name) {
    return _loginRepository.createUserWithEmailAndPassword(email, password, name);
  }

  Future<UserFirebaseModel> signInWithEmailAndPassword(String email, String password) {
    return _loginRepository.signInWithEmailAndPassword(email, password);
  }

  Future<bool> resetPassword(String email) async {
    return await _loginRepository.resetPassword(email);
  }

  void logOut() {
    return _loginRepository.logOut();
  }

  void verifyLoggedUser() {
    if (box.hasData("auth")) {
      UserModel user = UserModel(
        id: box.read("auth")["id"],
        email: box.read("auth")["email"],
        name: box.read("auth")["name"],
        phoneNumber: box.read("auth")["phoneNumber"],
      );
      Get.toNamed(Routes.NAVIGATION, arguments: user);
    }
  }

  void registerUser(String email, String password, String name, String phoneNumber) async {
    UserFirebaseModel firebaseUser = await createUserWithEmailAndPassword(
      email,
      password,
      name,
    );

    if (firebaseUser != null) {
      _userService.createUser(
        firebaseUser.id,
        firebaseUser.email,
        firebaseUser.name,
        phoneNumber,
      );
    }
  }

  void login(String email, String password) async {
    UserFirebaseModel firebaseUser = await signInWithEmailAndPassword(
      email,
      password,
    );

    if (firebaseUser != null) {
      UserModel user = await _userService.get(firebaseUser.id);
      box.write("auth", user);
      Get.toNamed(Routes.NAVIGATION, arguments: user);
    }
  }
}
