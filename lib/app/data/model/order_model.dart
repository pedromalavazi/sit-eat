import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id;
  Timestamp orderTime;
  bool productId;
  int quantity;
  String reservationId;
  double total;

  OrderModel({
    this.id,
    this.orderTime,
    this.productId,
    this.quantity,
    this.reservationId,
    this.total,
  });

  OrderModel.fromSnapshot(DocumentSnapshot order)
      : id = order.id,
        orderTime = order.data()["orderTime"],
        productId = order.data()["productId"],
        quantity = order.data()["quantity"],
        reservationId = order.data()["reservationId"],
        total = order.data()["total"];
}
