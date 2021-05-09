import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_firebase_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/provider/login_provider.dart';

class LoginRepository {
  final LoginApiClient apiClient = LoginApiClient();

  Future<UserFirebaseModel> createUserWithEmailAndPassword(
      String email, String password, String name) {
    return apiClient.createUserWithEmailAndPassword(email, password, name);
  }

  Future<UserFirebaseModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) {
    return apiClient.signInWithEmailAndPassword(email, password);
  }

  Future<bool> resetPassword(String email) async {
    return await apiClient.resetPassword(email);
  }

  Future<UserFirebaseModel> updateLoggedUser(
      UserModel user, String password) async {
    return await apiClient.updateLoggedUser(user, password);
  }

  void logOut() {
    return apiClient.logOut();
  }
}
