import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/order_model.dart';
import 'package:sit_eat/app/data/repository/order_repository.dart';

class OrderService extends GetxService {
  final OrderRepository _orderRepository = OrderRepository();

  Future<String> createOrder(OrderModel order) async {
    return await _orderRepository.createOrder(order);
  }

  Future<List<OrderModel>> getOrdersByUser(String userId, String reservationId) {
    return _orderRepository.getOrdersByUser(userId, reservationId);
  }

  Future<List<OrderModel>> getOrdersByReservation(String reservationId) {
    return _orderRepository.getOrdersByReservation(reservationId);
  }

  Future<void> removeOrder(String orderId) async {
    await _orderRepository.removeOrder(orderId);
  }

  Stream<List<OrderModel>> listenerOrders(String reservationId) {
    return _orderRepository.listenerOrders(reservationId);
  }
}
