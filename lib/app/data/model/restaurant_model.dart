import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  String id;
  String image;
  String name;
  int capacity;
  String address;

  RestaurantModel(
      {this.id, this.image, this.name, this.capacity, this.address});

  RestaurantModel.fromSnapshot(DocumentSnapshot restaurant)
      : id = restaurant["id"],
        image = restaurant["image"],
        name = restaurant["name"],
        capacity = restaurant["capacity"],
        address = restaurant["address"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "name": name,
      "capacity": capacity,
      "address": address,
    };
  }
}
