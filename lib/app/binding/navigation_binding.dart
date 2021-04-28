import 'package:get/get.dart';
import 'package:sit_eat/app/controller/navigation_controller.dart';

class NavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
  }
}
