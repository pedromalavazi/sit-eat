import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/repository/restaurant_repository.dart';

class HomeController extends GetxController {
  final RestaurantRepository _restaurantRepository = RestaurantRepository();
  final TextEditingController nameTextController = TextEditingController();

  RxList<RestaurantModel> restaurants = RxList<RestaurantModel>();

  HomeController(this.user);

  final UserModel user;
  RxString userName = "".obs;
  RxString valorQrCode = "".obs;
  RxString restaurantName = "".obs;
  RxInt restaurantCapacity = 0.obs;
  RxString restaurantImage = "".obs;

  @override
  void onReady() {
    setUser(user);
    getRestaurants();
    super.onReady();
  }

  setUser(UserModel user) {
    user = user;
    userName.value = user.name;
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
      valorQrCode.value = barcodeScanRes;
      pegarPassarRest(barcodeScanRes);
    }
  }

  void pegarPassarRest(String envioQr) async {
    RestaurantModel firebaseRest =
        await _restaurantRepository.getByQrCode(envioQr);

    valorQrCode.value = firebaseRest.name;
  }

  void getRestaurants() async {
    var restaurantsFromBase = await _restaurantRepository.getAll();
    restaurants.addAll(restaurantsFromBase);
  }
}
