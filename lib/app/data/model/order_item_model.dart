import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItemModel {
  String id;
  String orderId;
  String productId;
  bool quantity;
  double price;

  OrderItemModel({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
  });

  OrderItemModel.fromSnapshot(DocumentSnapshot orderItem)
      : id = orderItem.id,
        orderId = orderItem.data()["orderId"],
        productId = orderItem.data()["productId"],
        quantity = orderItem.data()["quantity"],
        price = orderItem.data()["price"];
}
