import 'package:get/get.dart';
import 'package:sit_eat/app/controller/menu_controller.dart';

class MenuBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuController>(() => MenuController());
  }
}
