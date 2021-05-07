import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/repository/restaurant_repository.dart';

class HomeController extends GetxController {
  final UserModel user;
  RxString userName = "".obs;

  RxString restaurantName = "".obs;
  RxInt restaurantCapacity = 0.obs;
  RxString restaurantImage = "".obs;

  RxList<RestaurantModel> restaurants = RxList<RestaurantModel>();

  HomeController(this.user);

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

  void getRestaurants() async {
    var teste = await _restaurantRespo.getAll();
    restaurants.addAll(teste);
  }
}
