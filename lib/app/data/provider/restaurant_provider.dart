import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';

class RestaurantApiClient {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<RestaurantModel> getRestaurant(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("restaurants").doc(id).get();
      RestaurantModel restaurant = RestaurantModel.fromSnapshot(doc);
      restaurant.id = id;
      return restaurant;
    } catch (e) {
      print(e.code);
      Get.back();
      Get.defaultDialog(
          title: "ERROR", content: Text("Restaurante não encontrado."));
      return RestaurantModel();
    }
  }
}
