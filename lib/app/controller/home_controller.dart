import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/provider/restaurant_provider.dart';

class HomeController extends GetxController {
  final UserModel user;
  HomeController(this.user);
  RxString userName = "".obs;

  final RestaurantApi _restaurantApi = RestaurantApi();

  @override
  void onReady() {
    setUser(user);
    _restaurantApi.getRestaurant("GrS18r6TofUkDrbD3J3U");
    super.onReady();
  }

  setUser(UserModel user) {
    user = user;
    userName.value = user.name;
  }
}
