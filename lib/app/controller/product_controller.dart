import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/services/menu_service.dart';
import 'package:flutter/material.dart';

class ProductController extends GetxController {
  final ProductService _menuService = ProductService();

  String productId = Get.arguments;
  Rx<ProductModel> product = ProductModel().obs;

  RxInt productCount = 0.obs;

  @override
  void onInit() async {
    getProductDetails();
    super.onInit();
  }

  void getProductDetails() async {
    ProductModel currentProduct = await _menuService.get(productId);
    product.value = currentProduct;
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
