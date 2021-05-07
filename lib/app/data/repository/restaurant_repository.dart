import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/provider/restaurant_provider.dart';

class RestaurantRepository {
  final RestaurantApiClient apiClient = RestaurantApiClient();

  Future<RestaurantModel> getByQrCode(String envioQr) async {
    return apiClient.getRestaurantByQrCode(envioQr);
  }

  Future<RestaurantModel> get(String id) {
    return apiClient.getRestaurant(id);
  }

  Future<List<RestaurantModel>> getAll() {
    return apiClient.getAllRestaurant();
  }
}
