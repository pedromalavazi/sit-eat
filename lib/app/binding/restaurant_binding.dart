import 'package:get/get.dart';
import 'package:sit_eat/app/controller/restaurant_controller.dart';

class RestaurantBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantController>(() => RestaurantController());
  }
}
