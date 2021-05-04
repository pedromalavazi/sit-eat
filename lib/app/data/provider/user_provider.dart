import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_eat/app/data/model/user_model.dart';

class UserApiClient {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cria usuáio
  Future<bool> createUser(
      String id, String email, String name, String phoneNumber) async {
    try {
      await _firestore.collection("users").doc(id).set({
        "email": email,
        "name": name,
        "phoneNumber": phoneNumber,
      });

      return true;
    } catch (e) {
      print(e.code);
      Get.back();
      Get.defaultDialog(
          title: "ERROR", content: Text("Usuário não encontrado."));
      return false;
    }
  }

  // Cria usuáio
  Future<UserModel> getUser(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection("users").doc(id).get();
      UserModel user = UserModel.fromSnapshot(doc);
      user.id = id;
      return user;
    } catch (e) {
      print(e.code);
      Get.back();
      Get.defaultDialog(
          title: "ERROR", content: Text("Usuário não encontrado."));
      return UserModel();
    }
  }
}
