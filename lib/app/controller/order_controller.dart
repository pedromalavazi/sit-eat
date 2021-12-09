import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/order_card_model.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/menu_service.dart';
import 'package:sit_eat/app/data/services/order_service.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class OrderController extends GetxController {
  final ReservationService _reservationService = ReservationService();
  final OrderService _orderService = OrderService();
  final ProductService _productService = ProductService();
  final UtilService _util = UtilService();

  String restaurantId, reservationId;
  RxList<OrderCardModel> allOrders = RxList<OrderCardModel>();
  RxList<ProductModel> products = RxList<ProductModel>();
  RxDouble total = 0.0.obs;

  RxDouble totalPedido = 0.0.obs;
  RxString totalPedidoText = "".obs;
  RxBool possuiPedido = false.obs;

  @override
  void onInit() async {
    await getCurrentRestaurantAndReservation();
    getOrders();
    super.onInit();
  }

  RxBool checkTotalPedidos() {
    if (total.value == 0.0) {
      this.possuiPedido.value = false;
    } else {
      this.possuiPedido.value = true;
    }
    return this.possuiPedido;
  }

  void calculatePedido(RxBool possuiPedido) {
    if (possuiPedido.isTrue) {
      this.totalPedidoText.value = ('R\$ ${_util.setCurrencyPattern(total.value)}');
    } else {
      this.totalPedidoText.value = null;
    }
  }

  Future<void> getCurrentRestaurantAndReservation() async {
    var reservation = await _reservationService.getActiveReservation(AuthService.to.user.value.id);
    this.restaurantId = reservation.restaurantId;
    this.reservationId = reservation.id;
  }

  // Preenche o OrderCardModel
  void getOrders() async {
    _orderService.listenerOrders(reservationId).listen((ordersFromRestaurant) async {
      this.allOrders.clear();
      this.total.value = 0.0;

      List<OrderCardModel> tempAllOrders = <OrderCardModel>[];
      for (var order in ordersFromRestaurant) {
        OrderCardModel cardTemp = OrderCardModel();
        var product = await getProductProps(order.productId);
        cardTemp.id = order.id;
        cardTemp.reservationId = order.reservationId;
        cardTemp.quantity = order.quantity;
        cardTemp.total = order.total;
        cardTemp.image = product.image;
        cardTemp.name = product.name;
        cardTemp.price = product.price;
        cardTemp.measure = product.measure;
        cardTemp.orderTime = order.orderTime;
        calculateTotal(product.price, order.quantity);
        tempAllOrders.add(cardTemp);
      }

      this.allOrders.addAll(tempAllOrders);
      calculatePedido(checkTotalPedidos());
    });
  }

  Future<ProductModel> getProductProps(String productId) async {
    ProductModel currentProduct = await _productService.get(productId);
    return currentProduct;
  }

  void calculateTotal(double price, int quantity) {
    double orderPrice = quantity * price;
    this.total.value += orderPrice;
  }

  Future<bool> checkCancelRequest(Timestamp orderTime) async {
    DateTime now = DateTime.now();
    var date = new DateTime.fromMicrosecondsSinceEpoch(orderTime.microsecondsSinceEpoch);
    var diff = date.difference(now);
    if (diff.inMinutes >= (-10)) {
      return true;
    } else
      return false;
  }

  Future<void> removeOrder(String orderId) async {
    await _orderService.removeOrder(orderId);
  }

  void cancelOrder(int index) async {
    var canDelete = await checkCancelRequest(this.allOrders[index].orderTime);
    if (canDelete) {
      Get.back();
      this.removeOrder(this.allOrders[index].id);
      _util.showSuccessMessage("Pedido cancelado", "O restaurante será notificado sobre o cancelamento!");
    } else {
      Get.back();
      _util.showSuccessMessage("Erro no cancelamento", "Restaurante já está preparando o pedido!");
    }
  }
}
