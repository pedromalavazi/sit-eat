import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/order_card_model.dart';
import 'package:sit_eat/app/data/model/order_model.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/menu_service.dart';
import 'package:sit_eat/app/data/services/order_service.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';

class OrderController extends GetxController {
  final ReservationService _reservationService = ReservationService();
  final OrderService _orderService = OrderService();
  final ProductService _productService = ProductService();

  String restaurantId;
  String reservationId;
  RxList<OrderCardModel> orders = RxList<OrderCardModel>();
  RxList<OrderModel> ordersFromRestaurant = RxList<OrderModel>();
  RxList<ProductModel> products = RxList<ProductModel>();
  RxDouble total = 0.0.obs;

  @override
  void onInit() async {
    getCurrentRestaurantAndReservation();
    getOrders();
    super.onInit();
  }

  Future<void> getCurrentRestaurantAndReservation() async {
    var reservation = await _reservationService
        .getActiveReservation(AuthService.to.user.value.id);

    restaurantId = reservation.restaurantId;
    reservationId = reservation.id;
  }

  // Preenche o OrderCardModel
  void getOrders() async {
    var ordersFromRestaurant = await _orderService.getOrdersByUser(
        AuthService.to.user.value.id, reservationId);

    for (var i = 0; i < ordersFromRestaurant.length; i++) {
      var order = ordersFromRestaurant[i];
      OrderCardModel cardTemp = OrderCardModel();
      var orderTemp = await getProductProps(order.productId);
      cardTemp.id = order.id;
      cardTemp.reservationId = order.reservationId;
      cardTemp.quantity = order.quantity;
      cardTemp.total = order.total;
      cardTemp.image = orderTemp.image;
      cardTemp.name = orderTemp.name;
      cardTemp.price = orderTemp.price;
      cardTemp.measure = orderTemp.measure;
      calculateTotal(orderTemp.price, order.quantity);
      orders.add(cardTemp);
    }
  }

  Future<ProductModel> getProductProps(String productId) async {
    ProductModel currentProduct = await _productService.get(productId);
    return currentProduct;
  }

  void calculateTotal(double price, int quantity) {
    double orderPrice = quantity * price;
    total.value += orderPrice;
  }
}
