import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantApi {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Retorna restaurante
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

// Retorna lista de restaurantes
  Future<List<RestaurantModel>> getAllRestaurant() async {
    try {
      var restaurants = <RestaurantModel>[];

      await _firestore
          .collection('restaurants')
          .limit(10)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((restaurant) {
          restaurants.add(RestaurantModel.fromSnapshot(restaurant));
        });
      });

      return restaurants;
    } catch (e) {
      print(e.code);
      Get.back();
      Get.defaultDialog(
          title: "ERROR",
          content: Text("Lista de restaurantes não encontrada."));
      return <RestaurantModel>[];
    }
  }
}
