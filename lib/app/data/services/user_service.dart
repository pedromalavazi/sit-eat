import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_firebase_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/repository/user_repository.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';

class UserService extends GetxService {
  final UserRepository _userRepository = UserRepository();

  Future<UserModel> get(String id) {
    return _userRepository.getUser(id);
  }

  Future<void> updateUserPassword(
      String password, String confirmPassword) async {
    if (!GetUtils.isNullOrBlank(password) &&
        !GetUtils.isNullOrBlank(confirmPassword)) {
      await AuthService.to.updateUserPassword(password);
    }
  }

  Future<UserFirebaseModel> updateUserDetails(String userName) async {
    return await AuthService.to.updateUserDetails(userName);
  }

  Future<bool> updateUser(
      UserModel user, String password, String confirmPassword) async {
    try {
      await updateUserPassword(password, confirmPassword);

      var newFirebaseUser = await updateUserDetails(user.name);

      if (newFirebaseUser != null) {
        await _userRepository.updateUser(user);
        AuthService.to.user.value.image = user.image;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<String> listenerUserPhoto() {
    return _userRepository.listenerUserPhoto(AuthService.to.user.value.id);
  }
}
