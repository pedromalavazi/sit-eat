import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String restaurantId;
  String image;
  String name;
  double price;
  String description;
  String measure;

  ProductModel({
    this.id,
    this.restaurantId,
    this.image,
    this.name,
    this.price,
    this.description,
    this.measure,
  });

  ProductModel.fromSnapshot(DocumentSnapshot product)
      : id = product.id,
        restaurantId = product.data()["restaurantId"],
        image = product.data()["image"],
        name = product.data()["name"],
        price = double.parse(product.data()["price"].toString()),
        description = product.data()["description"],
        measure = product.data()["measure"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "restaurantId": restaurantId,
      "image": image,
      "name": name,
      "price": price,
      "description": description,
      "measure": measure,
    };
  }
}
