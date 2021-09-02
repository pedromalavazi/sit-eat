import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/order_model.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/menu_service.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/data/services/order_service.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ProductController extends GetxController {
  final ProductService _menuService = ProductService();
  final OrderService _orderService = OrderService();
  final ReservationService _reservationService = ReservationService();
  Rx<UserModel> user = UserModel().obs;

  String productId = Get.arguments;
  Rx<ProductModel> product = ProductModel().obs;

  RxList<OrderModel> orders = RxList<OrderModel>();

  RxInt productCount = 0.obs;
  RxDouble price = 0.0.obs;

  @override
  void onInit() async {
    user = AuthService.to.user;
    getProductDetails();
    super.onInit();
  }

  void getProductDetails() async {
    ProductModel currentProduct = await _menuService.get(productId);
    product.value = currentProduct;
  }

  void createOrder() async {
    if (productCount.value > 0) {
      OrderModel order = OrderModel();
      var reservationId = await _reservationService.getReservationIdByUser(user.value.id);
      order.reservationId = reservationId;
      order.productId = product.value.id;
      order.quantity = productCount.value;
      order.userId = user.value.id;

      await _orderService.createOrder(order);
    } else {
      Get.snackbar('Erro', 'Quantidade inválida para realizar pedido', snackPosition: SnackPosition.BOTTOM);
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
