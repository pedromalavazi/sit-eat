import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_firebase_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/repository/login_repository.dart';
import 'package:sit_eat/app/data/repository/user_repository.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';

class UserService extends GetxService {
  final UserRepository _userRepository = UserRepository();

  Future<bool> createUser(
    String id,
    String email,
    String name,
    String phoneNumber,
  ) {
    return _userRepository.createUser(id, email, name, phoneNumber);
  }

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

  Future<UserFirebaseModel> updateUserName(String userName) async {
    return await AuthService.to.updateUserName(userName);
  }

  Future<void> updateUser(
      UserModel user, String password, String confirmPassword) async {
    // Atualiza senha
    await updateUserPassword(password, confirmPassword);
    //Atualiza usuário logado e o da base do firebase
    var newFirebaseUser = await updateUserName(user.name);

    if (newFirebaseUser != null) {
      //Atualiza usuário na nossa base
      await _userRepository.updateUser(user);
    }
  }
}
