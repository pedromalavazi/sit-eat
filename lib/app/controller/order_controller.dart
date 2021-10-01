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

  Rx<UserModel> user = UserModel().obs;
  String restaurantId = Get.arguments;
  Rx<OrderModel> order = OrderModel().obs;
  RxList<OrderCardModel> orders = RxList<OrderCardModel>();
  RxList<OrderModel> ordersFromRestaurant = RxList<OrderModel>();
  RxList<ProductModel> products = RxList<ProductModel>();
  RxDouble total = 0.0.obs;

  @override
  void onInit() async {
    user = AuthService.to.user;
    getOrders(user.value.id);
    super.onInit();
  }

  Future<String> getReservationId(String userId) async {
    var reservationId = await _reservationService.getReservationIdByUser(userId);
    return reservationId;
  }

  Future<void> getAllOrders(String userId, String reservationId) async {
    var ordersFromRestaurantId = await _orderService.getOrdersByUser(userId, reservationId);
    ordersFromRestaurant.addAll(ordersFromRestaurantId);
  }

  Future<ProductModel> getProductProps(String productId) async {
    ProductModel currentProduct = await _productService.get(productId);
    return currentProduct;
  }

  void calculateTotal(double price, int quantity) {
    double orderPrice = quantity * price;
    total.value += orderPrice;
  }

  // Preenche o OrderCardModel
  void getOrders(String userId) async {
    ordersFromRestaurant.clear();
    var reservationId = await getReservationId(userId);
    await getAllOrders(userId, reservationId);

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
}
