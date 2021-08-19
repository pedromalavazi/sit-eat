import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/repository/restaurant_repository.dart';

class RestaurantService extends GetxService {
  final RestaurantRepository _restaurantRepository = RestaurantRepository();

  Future<RestaurantModel> get(String id) async {
    if (GetUtils.isNullOrBlank(id)) {
      return null;
    }
    return await _restaurantRepository.getRestaurant(id);
  }

  Future<List<RestaurantModel>> getAll() {
    return _restaurantRepository.getAllRestaurant();
  }

  List<RestaurantModel> filterByName(
      List<RestaurantModel> restaurants, String name) {
    if (GetUtils.isNullOrBlank(name)) {
      return restaurants;
    }
    List<RestaurantModel> newRestaurants = <RestaurantModel>[];
    restaurants.forEach((restaurant) {
      if (restaurant.name.toLowerCase().contains(name.toLowerCase())) {
        newRestaurants.add(restaurant);
      }
    });
    return newRestaurants;
  }

  Future<RestaurantModel> getByQrCode(String envioQr) async {
    if (!GetUtils.isNullOrBlank(envioQr)) {
      return null;
    }
    return _restaurantRepository.getRestaurantByQrCode(envioQr);
  }

  bool verifyIsOpen(DateTime openTime, DateTime closeTime) {
    var now = DateTime.now();
    var openDate = DateTime(now.year, now.month, now.day, openTime.hour,
        openTime.minute, openTime.second);
    var closeDate = DateTime(now.year, now.month, now.day, closeTime.hour,
        closeTime.minute, closeTime.second);

    if (openDate.isAfter(closeDate)) {
      if (now.isAfter(openDate) || now.isBefore(closeDate)) {
        return true;
      }
    }

    if (now.isAfter(openDate) && now.isBefore(closeDate)) {
      return true;
    }

    return false;
  }

  String convertDateTimeToHourFormat(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime);
  }
}
