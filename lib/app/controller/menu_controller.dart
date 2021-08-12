import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/services/menu_service.dart';
import 'package:sit_eat/app/data/services/qr_code_service.dart';
import 'package:flutter/material.dart';

class MenuController extends GetxController {
  final MenuService _menuService = MenuService();
  final QrCodeService _qrCodeService = QrCodeService();
  final TextEditingController searchTextController = TextEditingController();

  String restaurantId = Get.arguments;
  RxList<ProductModel> allProducts = RxList<ProductModel>();
  RxList<ProductModel> products = RxList<ProductModel>();

  RxString productName = "".obs;
  RxInt productCount = 0.obs;
  RxString productImage = "".obs;

  @override
  void onInit() async {
    getProducts(restaurantId);
    super.onInit();
  }

  void getProducts(String restaurantId) async {
    var productsFromBase = await _menuService.getProducts(restaurantId);
    allProducts.addAll(productsFromBase);
    products.addAll(productsFromBase);
  }
}
