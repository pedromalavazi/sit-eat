import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/repository/restaurant_repository.dart';

class RestaurantController extends GetxController {
  final RestaurantRepository _restaurantRepository = RestaurantRepository();

  String restaurantId = Get.arguments;
  Rx<RestaurantModel> restaurant = RestaurantModel().obs;
  RxString openTimeFormat = "".obs;
  RxString closeTimeFormat = "".obs;
  RxBool isOpen = false.obs;

  @override
  void onReady() async {
    getRestaurant();
    super.onReady();
  }

  void getRestaurant() async {
    log(restaurantId);
    RestaurantModel currentRestaurant =
        await _restaurantRepository.get(restaurantId);
    restaurant.value = currentRestaurant;
    setTimes();
  }

  void setTimes() {
    var openDateTime = DateTime.fromMillisecondsSinceEpoch(
        restaurant.value.openTime.millisecondsSinceEpoch);
    openTimeFormat.value = DateFormat.Hm().format(openDateTime);
    var closeDateTime = DateTime.fromMillisecondsSinceEpoch(
        restaurant.value.closeTime.millisecondsSinceEpoch);
    closeTimeFormat.value = DateFormat.Hm().format(closeDateTime);

    setOpenOrClosed(openDateTime, closeDateTime);
  }

  void setOpenOrClosed(DateTime openTime, DateTime closeTime) {
    var now = DateTime.now();

    var openDate = DateTime(now.year, now.month, now.day, openTime.hour,
        openTime.minute, openTime.second);

    var closeDate = DateTime(now.year, now.month, now.day, closeTime.hour,
        closeTime.minute, closeTime.second);

    if (openDate.isAfter(closeDate) && now.isBefore(closeDate))
      isOpen.value = true;

    if (now.isAfter(openDate) && now.isBefore(closeDate)) isOpen.value = true;
  }

  void setPopulation() {}
}
