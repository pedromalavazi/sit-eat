import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/provider/user_provider.dart';

class UserRepository {
  final UserApiClient apiClient = UserApiClient();

  Future<bool> createUser(
    String id,
    String email,
    String name,
    String phoneNumber,
  ) {
    return apiClient.createUser(id, email, name, phoneNumber);
  }

  Future<UserModel> get(String id) {
    return apiClient.getUser(id);
  }
}
