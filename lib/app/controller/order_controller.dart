import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/order_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/order_service.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class OrderController extends GetxController {
  final _util = UtilService();

  final OrderService _orderService = OrderService();
  final ReservationService _reservationService = ReservationService();
  Rx<UserModel> user = UserModel().obs;
  RxString userName = "".obs;

  String restaurantId = Get.arguments;
  Rx<OrderModel> order = OrderModel().obs;
  RxList<OrderModel> orders = RxList<OrderModel>();

  @override
  void onInit() async {
    user = AuthService.to.user;
    getOrders(user.value.id);
    super.onInit();
  }

  void getOrders(String userId) async {
    var allOrders = await _orderService.getOrdersById(userId);
    orders.addAll(allOrders);
  }
}
