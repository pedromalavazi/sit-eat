import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  String id;
  String name;
  String address;
  String qrCode;
  int capacity;

  RestaurantModel(
      {this.id, this.name, this.address, this.qrCode, this.capacity});

  RestaurantModel.fromSnapshot(DocumentSnapshot currentUser)
      : id = currentUser.data()["id"],
        name = currentUser.data()["name"],
        address = currentUser.data()["address"],
        qrCode = currentUser.data()["qrCode"],
        capacity = currentUser.data()["capacit"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "qrCode": qrCode,
      "capacity": capacity,
    };
  }
}
