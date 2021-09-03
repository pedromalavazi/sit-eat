import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/services/menu_service.dart';
import 'package:flutter/material.dart';

class MenuController extends GetxController {
  final ProductService _productService = ProductService();

  String restaurantId = Get.arguments;
  RxList<ProductModel> products = RxList<ProductModel>();
  Rx<ProductModel> product = ProductModel().obs;

  RxInt productCount = 0.obs;

  @override
  void onInit() async {
    getProducts(restaurantId);
    super.onInit();
  }

  void getProducts(String restaurantId) async {
    var productsFromBase = await _productService.getProducts(restaurantId);
    products.addAll(productsFromBase);
  }

  void checkDecrease(RxInt itemCount) {
    if (productCount > 0) {
      productCount--;
    }
  }

  Widget setProductImage(String image) {
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
