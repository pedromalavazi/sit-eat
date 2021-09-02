import 'package:get/get.dart';
import 'package:sit_eat/app/controller/order_controller.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());
  }
}
