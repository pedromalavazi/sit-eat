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
  Future<RestaurantModel> getAllRestaurant() async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("restaurants").doc().get();
      RestaurantModel restaurant = RestaurantModel.fromSnapshot(doc);
      return RestaurantModel(
          id: restaurant.id,
          name: restaurant.name,
          image: restaurant.image,
          capacity: restaurant.capacity,
          address: restaurant.address);
    } catch (e) {
      print(e.code);
      Get.back();
      Get.defaultDialog(
          title: "ERROR",
          content: Text("Lista de restaurantes não encontrada."));
      return RestaurantModel();
    }
  }
}
