import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String id;
  String reservationId;
  bool paid;
  Timestamp orderTime;
  double total;

  OrderModel({
    this.id,
    this.reservationId,
    this.paid,
    this.orderTime,
    this.total,
  });

  OrderModel.fromSnapshot(DocumentSnapshot order)
      : id = order.id,
        reservationId = order.data()["reservationId"],
        paid = order.data()["paid"],
        orderTime = order.data()["orderTime"],
        total = order.data()["total"];
}
