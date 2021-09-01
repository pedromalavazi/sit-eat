import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/order_model.dart';
import 'package:sit_eat/app/data/repository/order_repository.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class OrderService extends GetxService {
  final OrderRepository _orderRepository = OrderRepository();
  final _util = UtilService();

  Future<String> createOrder(OrderModel order) async {
    return await _orderRepository.createOrder(order);
  }

  Future<List<OrderModel>> getOrdersById(String userId) {
    return _orderRepository.getOrdersById(userId);
  }
}
