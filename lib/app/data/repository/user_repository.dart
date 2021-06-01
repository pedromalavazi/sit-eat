import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/user_model.dart';

class UserRepository {
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

  // Consulta usuáio
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

  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).update({
        "name": user.name,
        "phoneNumber": user.phoneNumber,
      });
    } catch (e) {
      Get.defaultDialog(
          title: "ERROR",
          content: Text("Não foi possível atualizar os dados."));
    }
  }
}
