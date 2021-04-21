import 'package:sit_eat/app/data/model/user_firebase_model.dart';
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

  void signOut() {
    return apiClient.signOut();
  }
}
