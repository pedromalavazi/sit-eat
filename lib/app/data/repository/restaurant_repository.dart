import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/provider/restaurant_provider.dart';

class RestaurantRepository {
  final RestaurantApiClient apiRestaurant = RestaurantApiClient();

  Future<RestaurantModel> get(String id) async {
    return await apiRestaurant.getRestaurant(id);
  }
}
