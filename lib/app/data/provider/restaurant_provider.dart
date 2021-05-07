import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';

class RestaurantApiClient {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Retorna um restaurant

  Future<RestaurantModel> pegarRest(String qrCode) async {
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
}
