import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/model/table_model.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class RestaurantRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UtilService _utilService = UtilService();

  // Retorna um restaurant pelo QR Code
  Future<RestaurantModel> getRestaurantByQrCode(String qrCode) async {
    try {
      RestaurantModel restaurant;
      await _firestore
          .collection('restaurants')
          .where('qrCode', isEqualTo: qrCode)
          .where('active', isEqualTo: true)
          .get()
          .then(
            (QuerySnapshot doc) => {
              if (doc.docs.length > 0)
                {
                  restaurant = RestaurantModel.fromSnapshot(doc.docs.first),
                }
              else
                {
                  Get.defaultDialog(
                      title: "ERROR",
                      content: Text("Restaurante não encontrado.")),
                }
            },
          );

      return restaurant;
    } catch (e) {
      Get.defaultDialog(
          title: "ERROR", content: Text("Restaurante não encontrado."));
      return RestaurantModel();
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
          .where('active', isEqualTo: true)
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

  Future<void> setTableBusy(
      String restaurantId, String tableId, String reservationId) async {
    try {
      await _firestore
          .collection('restaurants/$restaurantId/tables')
          .doc(tableId)
          .update({
        "busy": true,
        "reservationId": reservationId,
      });
      return true;
    } catch (e) {
      Get.defaultDialog(
          title: "ERROR", content: Text("Erro ao atualizar o restaurante."));
      return false;
    }
  }

  Future<TableModel> getTable(String restaurantId, String reservationId) async {
    try {
      TableModel table;
      await _firestore
          .collection("restaurants/$restaurantId/tables")
          .where('reservationId', isEqualTo: reservationId)
          .get()
          .then(
            (QuerySnapshot doc) => {
              if (doc.docs.length == 1)
                {
                  table = TableModel.fromSnapshot(doc.docs.first),
                }
            },
          );
      return table;
    } catch (e) {
      _utilService.showErrorMessage("Erro", "Mesa não encontrada.");
      return TableModel();
    }
  }
}
