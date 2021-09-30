import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id;
  Timestamp orderTime;
  String userId;
  String reservationId;
  String productId;
  int quantity;
  double total;
  bool delivered;

  OrderModel({this.id, this.orderTime, this.productId, this.quantity, this.reservationId, this.total, this.userId, this.delivered});

  OrderModel.fromSnapshot(DocumentSnapshot order)
      : id = order.id,
        orderTime = order.data()["orderTime"],
        productId = order.data()["productId"],
        quantity = order.data()["quantity"],
        reservationId = order.data()["reservationId"],
        total = order.data()["total"],
        userId = order.data()["userId"],
        delivered = order.data()["delivered"];
}

List<OrderModel> convertOrdersFromDB(QuerySnapshot ordersFromDB) {
  List<OrderModel> orders = <OrderModel>[];
  ordersFromDB.docs.forEach((order) {
    orders.add(OrderModel.fromSnapshot(order));
  });
  return orders;
}
