import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  String id;
  String image;
  String name;
  String address;
  int capacity;
  Timestamp openTime;
  Timestamp closeTime;

  RestaurantModel({
    this.id,
    this.image,
    this.name,
    this.address,
    this.capacity,
    this.openTime,
    this.closeTime,
  });

  RestaurantModel.fromSnapshot(DocumentSnapshot restaurant)
      : id = restaurant.data()["id"],
        image = restaurant.data()["image"],
        name = restaurant.data()["name"],
        address = restaurant.data()["address"],
        capacity = restaurant.data()["capacity"],
        openTime = restaurant.data()["openTime"],
        closeTime = restaurant.data()["closeTime"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "name": name,
      "address": address,
      "capacity": capacity,
      "openTime": openTime,
      "closeTime": closeTime
    };
  }
}
