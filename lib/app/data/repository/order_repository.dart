import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/order_model.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class OrderRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UtilService _util = UtilService();

  // Cria novo pedido
  Future<String> createOrder(OrderModel order) async {
    try {
      var orderId = await _firestore.collection("orders").add(
        {
          "userId": order.userId,
          "productId": order.productId,
          "reservationId": order.reservationId,
          "quantity": order.quantity,
          "orderTime": DateTime.now(),
          "delivered": false,
          "viewed": false,
        },
      );
      return orderId.id;
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Não foi possível criar nova ordem.");
      return "";
    }
  }

  // Retorna lista de pedidos/orders por reserva do usuário
  Future<List<OrderModel>> getOrdersByUser(String reservationId) async {
    try {
      var orders = <OrderModel>[];
      await _firestore
          .collection('orders')
          .where('reservationId', isEqualTo: reservationId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((order) {
          orders.add(OrderModel.fromSnapshot(order));
        });
      });
      return orders;
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Não foi possível recuperar a lista de pedidos.");
      return <OrderModel>[];
    }
  }

  Future<List<OrderModel>> getOrdersByReservation(String reservationId) async {
    try {
      var orders = <OrderModel>[];
      await _firestore
          .collection('orders')
          .where('reservationId', isEqualTo: reservationId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((order) {
          orders.add(OrderModel.fromSnapshot(order));
        });
      });
      return orders;
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Não foi possível recuperar a lista de pedidos.");
      return <OrderModel>[];
    }
  }

  // Remove pedido por ID
  Future<void> removeOrder(String orderId) async {
    try {
      var orderItem = _firestore.collection("orders").doc(orderId);
      orderItem.delete();
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Não foi possível remover o pedido.");
    }
  }

  Stream<List<OrderModel>> listenerOrders(String reservationId) {
    return _firestore.collection('orders').where('reservationId', isEqualTo: reservationId).snapshots().map((doc) {
      if (doc.docs.length == 0) {
        return <OrderModel>[];
      }
      return convertOrdersFromDB(doc);
    });
  }
}
