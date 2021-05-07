import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/provider/restaurant_provider.dart';

class RestaurantRepository {
  final RestaurantApiClient apiClient = RestaurantApiClient();

  Future<RestaurantModel> pegarRest(String envioQr) async {
    return apiClient.pegarRest(envioQr);
  }
}
