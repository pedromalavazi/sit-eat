import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sit_eat/app/data/model/user_firebase_model.dart';

class LoginApiClient {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        case "ERROR_OPERATION_NOT_ALLOWED":
          Get.defaultDialog(
              title: "ERROR",
              content: Text("Contas anônimas não estão habilitadas"));
          break;
        case "ERROR_WEAK_PASSWORD":
          Get.defaultDialog(
              title: "ERROR", content: Text("Sua senha é muito fraca"));
          break;
        case "ERROR_INVALID_EMAIL":
          Get.defaultDialog(
              title: "ERROR", content: Text("Seu email é inválido"));
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          Get.defaultDialog(
              title: "ERROR",
              content: Text("O e-mail já está em uso em outra conta"));
          break;
        case "ERROR_INVALID_CREDENTIAL":
          Get.defaultDialog(
              title: "ERROR", content: Text("Seu email é inválido"));
          break;
        default:
          Get.defaultDialog(
              title: "ERROR", content: Text("Ocorreu um erro indefinido."));
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
        case "ERROR_USER_NOT_FOUND":
          Get.defaultDialog(
              title: "ERROR", content: Text("Usuário não encontrado."));
          break;
        case "ERROR_WRONG_PASSWORD":
          Get.defaultDialog(
              title: "ERROR",
              content: Text("Senha não confere com o cadastrado."));
          break;
        case "ERROR_USER_DISABLED":
          Get.defaultDialog(
              title: "ERROR", content: Text("Este usuário foi desativado."));
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          Get.defaultDialog(
              title: "ERROR",
              content:
                  Text("Muitos solicitações. Tente novamente mais tarde."));
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          Get.defaultDialog(
              title: "ERROR",
              content:
                  Text("Este login com e-mail e senha não foi permitida."));
          break;
        default:
          Get.defaultDialog(title: "ERROR", content: Text("$e"));
          break;
      }
      return null;
    }
  }

  // Fazer Logoff
  signOut() {
    //dbox.write("auth", null);
    //box.erase();
    return _firebaseAuth.signOut();
  }
}
