import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sit_eat/app/data/model/user_firebase_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';

class LoginRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GetStorage box = GetStorage('sit_eat');

  // Retorna usuário logado
  Stream<UserFirebaseModel> get onAuthStateChanged => _firebaseAuth.authStateChanges().map((User currentUser) => UserFirebaseModel.fromSnapshot(currentUser));

  // Criar usuário
  Future<UserFirebaseModel> createUserWithEmailAndPassword(String email, String password, String name) async {
    try {
      (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;

      // Atualizando o nome do usuário
      await _firebaseAuth.currentUser.updateProfile(displayName: name);
      await _firebaseAuth.currentUser.reload();

      return UserFirebaseModel.fromSnapshot(_firebaseAuth.currentUser);
    } catch (e) {
      print(e.code);
      Get.back();
      switch (e.code) {
        case "operation-not-allowed":
          showMessage(
            "Erro",
            "O provedor de login fornecido está desativado para o projeto do Firebase.",
          );
          break;
        case "invalid-password":
          showMessage("Erro", "Senha fraca. É necessário seis caracteres.");
          break;
        case "invalid-email":
          showMessage("Erro", "E-mail é inválido.");
          break;
        case "email-already-exists":
          showMessage("Erro", "E-mail já cadastrado.");
          break;
        case "invalid-credential":
          showMessage("Erro", "Email inválido.");
          break;
        default:
          showMessage(
            "Erro",
            "Erro desconhecido, tente novamente mais tarde ou entre em contato com nosso e-mail: appsiteat@gmail.com",
          );
      }
      return null;
    }
  }

  // Fazer Login
  Future<UserFirebaseModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      final currentUser = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
      return UserFirebaseModel.fromSnapshot(currentUser);
    } catch (e) {
      print(e.code);
      Get.back();
      switch (e.code) {
        case "user-not-found":
          showMessage("Erro", "Usuário ou senha incorreta.");
          break;
        case "invalid-password":
          showMessage("Erro", "Usuário ou senha incorreta.");
          break;
        case "operation-not-allowed":
          showMessage("Erro", "Login não permitido.");
          break;
        default:
          showMessage(
            "Erro",
            "Erro desconhecido, tente novamente mais tarde ou entre em contato com nosso e-mail: appsiteat@gmail.com.",
          );
          break;
      }
      return null;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Get.back();
      showMessage("Aviso", "E-mail enviado");
      return true;
    } catch (e) {
      switch (e.code) {
        case "user-not-found":
          showMessage("Erro", "Usuário não encontrado.");
          break;
        default:
          showMessage(
            "Erro",
            "Erro desconhecido, tente novamente mais tarde ou entre em contato com nosso e-mail: appsiteat@gmail.com",
          );
          break;
      }
      return false;
    }
  }

  Future<UserFirebaseModel> updateUserName(String userName) async {
    try {
      await _firebaseAuth.currentUser.updateProfile(displayName: userName);
      await _firebaseAuth.currentUser.reload();
      return UserFirebaseModel.fromSnapshot(_firebaseAuth.currentUser);
    } catch (e) {
      showMessage(
        "Erro",
        "Erro desconhecido, não foi possível atualizar os dados.",
      );
      return null;
    }
  }

  Future<UserFirebaseModel> updateUserPassword(String password) async {
    try {
      await _firebaseAuth.currentUser.updatePassword(password);
      await _firebaseAuth.currentUser.reload();
      return UserFirebaseModel.fromSnapshot(_firebaseAuth.currentUser);
    } catch (e) {
      showMessage(
        "Erro",
        "Erro desconhecido, não foi possível atualizar os dados.",
      );
      return null;
    }
  }

  showMessage(String title, String message) {
    return Get.defaultDialog(
      title: title,
      content: Text(
        message,
      ),
      onConfirm: () {
        Get.back();
      },
    );
  }

  logOut() {
    box.write("auth", null);
    return _firebaseAuth.signOut();
  }
}
