import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/provider/restaurant_provider.dart';

class RestaurantRepository {
  final RestaurantApi apiRestaurant = RestaurantApi();

  Future<RestaurantModel> get(String id) {
    return apiRestaurant.getRestaurant(id);
  }
}
