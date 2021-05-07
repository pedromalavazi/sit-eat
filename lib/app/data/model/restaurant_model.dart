import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  String id;
  String name;
  String address;
  String qrCode;
  int capacity;
  String image;

  RestaurantModel(
      {this.id,
      this.name,
      this.address,
      this.qrCode,
      this.capacity,
      this.image});

  RestaurantModel.fromSnapshot(DocumentSnapshot restaurant)
      : id = restaurant.data()["id"],
        name = restaurant.data()["name"],
        address = restaurant.data()["address"],
        qrCode = restaurant.data()["qrCode"],
        image = restaurant.data()["image"],
        capacity = restaurant.data()["capacity"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "qrCode": qrCode,
      "capacity": capacity,
      "image": image,
    };
  }
}
