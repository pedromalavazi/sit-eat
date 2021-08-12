import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class MenuRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UtilService _util = UtilService();

  // Retorna lista de produtos do restaurante
  Future<List<ProductModel>> getProducts(String restaurantId) async {
    try {
      var products = <ProductModel>[];
      await _firestore.collection('products').where('restaurantId', isEqualTo: restaurantId).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((product) {
          products.add(ProductModel.fromSnapshot(product));
        });
      });
      return products;
    } catch (e) {
      print(e.code);
      Get.back();
      _util.showErrorMessage("Erro", "Não foi possível recuperar as reservas.");
      return <ProductModel>[];
    }
  }
}
