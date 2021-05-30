import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sit_eat/app/data/model/user_firebase_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';

class AuthService extends GetxController {
  GetStorage box = GetStorage('sit_eat');
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _firebaseUser;
  Rx<UserModel> _user;
  var userIsAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();

    _firebaseUser = Rx<User>(_auth.currentUser);
    _user = Rx<UserModel>(UserModel());
    _firebaseUser.bindStream(_auth.authStateChanges());

    ever(_firebaseUser, (User user) {
      if (user != null) {
        userIsAuthenticated.value = true;
      } else {
        userIsAuthenticated.value = false;
      }
    });

    verifyLoggedUser();
  }

  @override
  void onClose() {}

  User get firebaseUser => _firebaseUser.value;
  Rx<UserModel> get user => _user;
  static AuthService get to => Get.find<AuthService>();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  createUser(
      String email, String password, String name, String phoneNumber) async {
    try {
      //Cria usuário do Firebase
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Atualizando o nome do usuário
      await _firebaseUser.value.updateProfile(displayName: name);
      await _firebaseUser.value.reload();

      //Cria usuário de controle do app
      await _firestore.collection("users").doc(_firebaseUser.value.uid).set({
        "email": email,
        "name": name,
        "phoneNumber": phoneNumber,
      });
    } catch (e) {
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
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
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
      await _auth.currentUser.updateProfile(displayName: userName);
      await _auth.currentUser.reload();
      return UserFirebaseModel.fromSnapshot(_auth.currentUser);
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
      await _auth.currentUser.updatePassword(password);
      await _auth.currentUser.reload();
      box.write("auth", {"email": box.read("auth")["email"], "pass": password});
      return UserFirebaseModel.fromSnapshot(_auth.currentUser);
    } catch (e) {
      showMessage(
        "Erro",
        "Erro desconhecido, não foi possível atualizar os dados.",
      );
      return null;
    }
  }

  login(String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      box.write("auth", {"email": email, "pass": password});
      _user.value = UserModel.fromSnapshot(
          await _firestore.collection("users").doc(user.user.uid).get());
      _user.value.id = user.user.uid;
    } catch (e) {
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
    }
  }

  logout() async {
    try {
      box.write("auth", null);
      await _auth.signOut();
    } catch (e) {
      showMessage('Erro ao sair!', e.message);
    }
  }

  Future<bool> verifyLoggedUser() async {
    if (box.hasData("auth")) {
      await login(box.read("auth")["email"], box.read("auth")["pass"]);
      return true;
    }
    return false;
  }

  showMessage(String title, String message) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: Colors.grey[700],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
