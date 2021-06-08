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

  Future<bool> login(String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      box.write("auth1", {"email": email, "pass": password});
      _user.value = UserModel.fromSnapshot(
          await _firestore.collection("users").doc(user.user.uid).get());
      _user.value.id = user.user.uid;
      return true;
    } catch (e) {
      throwErrorMessage(e.code);
      return false;
    }
  }

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
      throwErrorMessage(e.code);
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.back();
      showMessage("Aviso", "E-mail enviado");
      return true;
    } catch (e) {
      throwErrorMessage(e.code);
      return false;
    }
  }

  Future<UserFirebaseModel> updateUserName(String userName) async {
    try {
      await _auth.currentUser.updateProfile(displayName: userName);
      await _auth.currentUser.reload();
      return UserFirebaseModel.fromSnapshot(_auth.currentUser);
    } catch (e) {
      throwErrorMessage(e.code);
      return UserFirebaseModel();
    }
  }

  Future<UserFirebaseModel> updateUserPassword(String password) async {
    try {
      await _auth.currentUser.updatePassword(password);
      await _auth.currentUser.reload();
      box.write("auth1", null);
      box.write(
          "auth1", {"email": box.read("auth1")["email"], "pass": password});
      return UserFirebaseModel.fromSnapshot(_auth.currentUser);
    } catch (e) {
      throwErrorMessage(e.code);
      return UserFirebaseModel();
    }
  }

  logout() async {
    try {
      box.write("auth1", null);
      await _auth.signOut();
    } catch (e) {
      showMessage('Erro ao sair!', e.message);
    }
  }

  Future<bool> verifyLoggedUser() async {
    if (box.hasData("auth1")) {
      await login(box.read("auth1")["email"], box.read("auth1")["pass"]);
      return true;
    }
    return false;
  }

  throwErrorMessage(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        showErrorMessage("Erro", "Usuário não encontrado.");
        break;
      case "wrong-password":
        showErrorMessage("Erro", "Usuário ou senha incorreta.");
        break;
      case "operation-not-allowed":
        showErrorMessage("Erro", "Login não permitido.");
        break;
      case "invalid-password":
        showErrorMessage("Erro", "Senha fraca. É necessário seis caracteres.");
        break;
      case "invalid-email":
        showErrorMessage("Erro", "E-mail é inválido.");
        break;
      case "email-already-exists":
        showErrorMessage("Erro", "E-mail já cadastrado.");
        break;
      case "invalid-credential":
        showErrorMessage("Erro", "Email inválido.");
        break;
      default:
        showErrorMessage(
          "Erro",
          "Erro desconhecido, tente novamente mais tarde ou entre em contato com nosso e-mail: appsiteat@gmail.com",
        );
    }
  }

  showErrorMessage(String title, String message) {
    Get.back();
    return Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.red[400],
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.error, color: Colors.white),
      shouldIconPulse: true,
    );
  }

  showMessage(String title, String message) {
    Get.back();
    return Get.snackbar(
      title,
      message,
      colorText: Colors.black,
      backgroundColor: Colors.grey[600],
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
      icon: Icon(Icons.info, color: Colors.white),
      shouldIconPulse: true,
    );
  }
}
