import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/provider/restaurant_provider.dart';
import 'package:sit_eat/app/data/repository/restaurant_repository.dart';

class HomeController extends GetxController {
  final UserModel user;
  HomeController(this.user);
  RxString userName = "".obs;

  final RestaurantRepository _restaurantRespo = RestaurantRepository();

  @override
  void onReady() {
    setUser(user);
    getRestaurants();
    super.onReady();
  }

  setUser(UserModel user) {
    user = user;
    userName.value = user.name;
  }

  void getRestaurants() {
    var teste = _restaurantRespo.getAll();
  }
}
