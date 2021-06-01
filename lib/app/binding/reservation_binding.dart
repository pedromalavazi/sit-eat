import 'package:get/get.dart';
import 'package:sit_eat/app/controller/reservation_controller.dart';

class ReservationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReservationController>(() => ReservationController());
  }
}
