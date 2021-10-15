import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/menu_service.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';

class MenuController extends GetxController {
  final ProductService _productService = ProductService();
  final ReservationService _reservationService = ReservationService();

  String restaurantId;
  RxList<ProductModel> products = RxList<ProductModel>();
  Rx<ProductModel> product = ProductModel().obs;

  RxInt productCount = 0.obs;

  @override
  void onInit() async {
    await getCurrentRestaurant();
    await getProducts();
    super.onInit();
  }

  Future<void> getCurrentRestaurant() async {
    var reservation = await _reservationService
        .getActiveReservation(AuthService.to.user.value.id);

    restaurantId = reservation.restaurantId;
  }

  Future<void> getProducts() async {
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
