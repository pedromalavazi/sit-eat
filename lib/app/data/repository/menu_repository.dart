import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_eat/app/data/model/product_model.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class ProductRepository {
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
      _util.showErrorMessage("Erro", "Não foi possível recuperar os produtos do restaurante.");
      return <ProductModel>[];
    }
  }

  // Retorna produto pelo ID
  Future<ProductModel> getProduct(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection("products").doc(id).get();
      ProductModel product = ProductModel.fromSnapshot(doc);
      product.id = id;
      return product;
    } catch (e) {
      print(e.code);
      Get.back();
      Get.defaultDialog(title: "ERROR", content: Text("Produto não encontrado."));
      return ProductModel();
    }
  }
}
