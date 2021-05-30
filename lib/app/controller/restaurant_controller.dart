import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/services/restaurant_service.dart';

class RestaurantController extends GetxController {
  final RestaurantService _restaurantService = RestaurantService();

  String restaurantId = Get.arguments;
  Rx<RestaurantModel> restaurant = RestaurantModel().obs;
  RxString openTimeFormat = "".obs;
  RxString closeTimeFormat = "".obs;
  RxBool isOpen = false.obs;

  @override
  void onInit() async {
    getRestaurant();
    super.onInit();
  }

  void getRestaurant() async {
    RestaurantModel currentRestaurant =
        await _restaurantService.get(restaurantId);
    restaurant.value = currentRestaurant;
    setTimes();
  }

  void setTimes() {
    var openDateTime = DateTime.fromMillisecondsSinceEpoch(
        restaurant.value.openTime.millisecondsSinceEpoch);
    openTimeFormat.value = _restaurantService.convertDateTimeToHourFormat(
      openDateTime,
    );

    var closeDateTime = DateTime.fromMillisecondsSinceEpoch(
        restaurant.value.closeTime.millisecondsSinceEpoch);
    closeTimeFormat.value = _restaurantService.convertDateTimeToHourFormat(
      closeDateTime,
    );

    setOpenOrClosed(openDateTime, closeDateTime);
  }

  void setOpenOrClosed(DateTime openTime, DateTime closeTime) {
    isOpen.value = _restaurantService.verifyIsOpen(openTime, closeTime);
  }

  Widget setRestaurantImage(String image) {
    if (GetUtils.isNullOrBlank(image)) {
      return Container(
        child: Image.asset("assets/logo-only.png"),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }
}
