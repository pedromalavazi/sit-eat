import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/restaurant_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final RestaurantService _restaurantService = RestaurantService();
  final TextEditingController nameTextController = TextEditingController();

  RxList<RestaurantModel> restaurants = RxList<RestaurantModel>();
  Rx<UserModel> user = UserModel().obs;
  RxString userName = "".obs;
  RxString valorQrCode = "".obs;
  RxString restaurantName = "".obs;
  RxInt restaurantCapacity = 0.obs;
  RxString restaurantImage = "".obs;

  @override
  void onInit() {
    super.onInit();
    setUser();
    getRestaurants();
  }

  setUser() {
    user = AuthService.to.user;
  }

  Future<void> scanQrCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      'red',
      'Cancelar',
      false,
      ScanMode.QR,
    );

    if (barcodeScanRes == '-1') {
      Get.snackbar('Cancelado', 'Leitura cancelada');
    } else {
      getRestaurantByQrCode(barcodeScanRes);
    }
  }

  void getRestaurantByQrCode(String qrCode) async {
    RestaurantModel restaurant = await _restaurantService.getByQrCode(qrCode);
    Get.toNamed(Routes.RESTAURANT, arguments: restaurant.id);
  }

  void getRestaurants() async {
    var restaurantsFromBase = await _restaurantService.getAll();
    restaurants.addAll(restaurantsFromBase);
  }
}
