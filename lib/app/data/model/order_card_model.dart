import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCardModel {
  String id;
  Timestamp orderTime;
  String userId;
  String reservationId;
  String productId;
  int quantity;
  double total;
  String image;
  String name;
  double price;
  String description;
  String measure;

  OrderCardModel({
    this.id,
    this.orderTime,
    this.userId,
    this.reservationId,
    this.productId,
    this.quantity,
    this.total,
    this.image,
    this.name,
    this.price,
    this.description,
    this.measure,
  });
}
