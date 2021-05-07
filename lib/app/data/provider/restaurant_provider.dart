import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';

class RestaurantApiClient {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Retorna um restaurant pelo QR Code
  Future<RestaurantModel> getRestaurantByQrCode(String qrCode) async {
    try {
      RestaurantModel teste;
      await _firestore
          .collection('restaurants')
          .where('qrCode', isEqualTo: qrCode)
          .get()
          .then((QuerySnapshot doc) => {
                if (doc.docs.length > 0)
                  {
                    teste = RestaurantModel.fromSnapshot(doc.docs.first),
                  }
                else
                  {
                    Get.defaultDialog(
                        title: "ERROR",
                        content: Text("Restaurante não encontrado.")),
                  }
              });

      return teste;
    } catch (e) {
      Get.defaultDialog(
          title: "ERROR", content: Text("Restaurante não encontrado."));
      print(e);
    }
  }

  // Retorna restaurante pelo ID
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
