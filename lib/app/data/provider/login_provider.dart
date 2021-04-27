import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sit_eat/app/data/model/user_firebase_model.dart';

class LoginApiClient {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GetStorage box = GetStorage('sit_eat');

  // Retorna usuário logado
  Stream<UserFirebaseModel> get onAuthStateChanged => _firebaseAuth
      .authStateChanges()
      .map((User currentUser) => UserFirebaseModel.fromSnapshot(currentUser));

  // Criar usuário
  Future<UserFirebaseModel> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final currentUser = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      // Atualizando o nome do usuário
      await currentUser.updateProfile(displayName: name);
      await currentUser.reload();

      return UserFirebaseModel.fromSnapshot(currentUser);
    } catch (e) {
      print(e.code);
      Get.back();
      switch (e.code) {
        case "operation-not-allowed":
          Get.defaultDialog(
              title: "Erro",
              content: Text(
                  "O provedor de login fornecido está desativado para o projeto do Firebase."));
          break;
        case "invalid-password":
          Get.defaultDialog(
              title: "Erro",
              content: Text("Senha fraca. É necessário seis caracteres"));
          break;
        case "invalid-email":
          Get.defaultDialog(title: "ERROR", content: Text("E-mail é inválido"));
          break;
        case "email-already-exists":
          Get.defaultDialog(
              title: "Erro", content: Text("E-mail já cadastrado"));
          break;
        case "invalid-credential":
          Get.defaultDialog(title: "ERROR", content: Text("Email inválido"));
          break;
        default:
          Get.defaultDialog(
              title: "Erro",
              content: Text(
                  "Erro desconhecido, tente novamente mais tarde ou entre em contato com nosso e-mail: appsiteat@gmail.com"));
      }
      return null;
    }
  }

  // Fazer Login
  Future<UserFirebaseModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final currentUser = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return UserFirebaseModel.fromSnapshot(currentUser);
    } catch (e) {
      print(e.code);
      Get.back();
      switch (e.code) {
        case "user-not-found":
          Get.defaultDialog(
              title: "Erro", content: Text("Usuário ou senha incorreta."));
          break;
        case "invalid-password":
          Get.defaultDialog(
              title: "Erro", content: Text("Usuário ou senha incorreta"));
          break;
        case "operation-not-allowed":
          Get.defaultDialog(
              title: "Erro", content: Text("Login não permitido."));
          break;
        default:
          Get.defaultDialog(
              title: "Erro",
              content: Text(
                  "Erro desconhecido, tente novamente mais tarde ou entre em contato com nosso e-mail: appsiteat@gmail.com"));
          break;
      }
      return null;
    }
  }

  logOut() {
    box.write("auth", null);
    return _firebaseAuth.signOut();
  }
}
