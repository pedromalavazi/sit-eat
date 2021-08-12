import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  String id;
  String image;
  String name;
  String address;
  int capacity;
  Timestamp openTime;
  Timestamp closeTime;
  String menu;
  bool active;

  RestaurantModel(
      {this.id,
      this.image,
      this.name,
      this.address,
      this.capacity,
      this.openTime,
      this.closeTime,
      this.menu,
      this.active});

  RestaurantModel.fromSnapshot(DocumentSnapshot restaurant)
      : id = restaurant.id,
        image = restaurant.data()["image"],
        name = restaurant.data()["name"],
        address = restaurant.data()["address"],
        capacity = restaurant.data()["capacity"],
        openTime = restaurant.data()["openTime"],
        closeTime = restaurant.data()["closeTime"],
        menu = restaurant.data()["menu"],
        active = restaurant.data()["active"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "name": name,
      "address": address,
      "capacity": capacity,
      "openTime": openTime,
      "closeTime": closeTime,
      "menu": menu,
      "active": active,
    };
  }
}
