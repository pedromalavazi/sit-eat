import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sit_eat/app/data/model/enum/login_status_enum.dart';
import 'package:sit_eat/app/data/model/enum/login_type_enum.dart';
import 'package:sit_eat/app/data/model/user_firebase_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class AuthService extends GetxController {
  final UtilService _util = UtilService();

  static const TABLE = 'users';
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

  Rx<User> get firebaseUser => _firebaseUser;
  Rx<UserModel> get user => _user;
  static AuthService get to => Get.find<AuthService>();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(String email, String password) async {
    try {
      if (email.isBlank || password.isBlank) return false;

      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _user.value = UserModel.fromSnapshot(
          await _firestore.collection(TABLE).doc(user.user.uid).get());

      if (_user.value.type != LoginType.CLIENT) {
        resetUser();
        Get.back();
        _util.showErrorMessage(
          "Usuário inválido",
          "Usuário não encontrado",
        );
        return false;
      }

      _user.value.id = user.user.uid;
      box.write("auth2", {"email": email, "pass": password});
      return true;
    } catch (e) {
      throwErrorMessage(e.code);
      resetUser();
      return false;
    }
  }

  resetUser() async {
    _user.value = UserModel();
    _auth.signOut();
    box.write("auth2", null);
  }

  Future<bool> createUser(
      String email, String password, String name, String phoneNumber) async {
    try {
      //Cria usuário do Firebase
      var newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Atualizando o nome do usuário
      await _firebaseUser.value.updateProfile(displayName: name);
      await _firebaseUser.value.reload();
      var tokenMessage = await _firebaseMessaging.getToken();
      //Cria usuário de controle do app
      await _firestore.collection(TABLE).doc(newUser.user.uid).set({
        "email": email,
        "name": name,
        "phoneNumber": phoneNumber,
        "tokenMessage": tokenMessage,
        "type": LoginType.CLIENT.toUpper,
        "status": LoginStatus.OUT.toUpper,
      });

      return true;
    } catch (e) {
      Get.back();
      throwErrorMessage(e.code);
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.back();
      _util.showInformationMessage("Aviso", "E-mail enviado");
      return true;
    } catch (e) {
      throwErrorMessage(e.code);
      return false;
    }
  }

  Future<UserFirebaseModel> updateUserDetails(String userName) async {
    try {
      await _firebaseUser.value.updateProfile(displayName: userName);
      await _firebaseUser.value.reload();
      return UserFirebaseModel.fromSnapshot(_firebaseUser.value);
    } catch (e) {
      throwErrorMessage(e.code);
      return UserFirebaseModel();
    }
  }

  Future<UserFirebaseModel> updateUserPassword(String password) async {
    try {
      await _auth.currentUser.updatePassword(password);
      await _auth.currentUser.reload();
      box.write("auth2", null);
      box.write(
          "auth2", {"email": box.read("auth2")["email"], "pass": password});
      return UserFirebaseModel.fromSnapshot(_auth.currentUser);
    } catch (e) {
      throwErrorMessage(e.code);
      return UserFirebaseModel();
    }
  }

  logout() async {
    try {
      box.write("auth2", null);
      await _auth.signOut();
    } catch (e) {
      _util.showErrorMessage('Erro ao sair!', e.message);
    }
  }

  Future<bool> verifyLoggedUser() async {
    if (!box.hasData("auth2")) return false;

    return await login(box.read("auth2")["email"], box.read("auth2")["pass"]);
  }

  Stream<UserModel> userListener(String id) {
    return _firestore.collection(TABLE).doc(id).snapshots().map((doc) {
      return UserModel.fromSnapshot(doc);
    });
  }

  throwErrorMessage(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        _util.showErrorMessage("Erro", "Usuário não encontrado.");
        break;
      case "wrong-password":
        _util.showErrorMessage("Erro", "Usuário ou senha incorreta.");
        break;
      case "operation-not-allowed":
        _util.showErrorMessage("Erro", "Login não permitido.");
        break;
      case "invalid-password":
        _util.showErrorMessage(
            "Erro", "Senha fraca. É necessário seis caracteres.");
        break;
      case "weak-password":
        _util.showErrorMessage("Erro", "Senha fraca.");
        break;
      case "invalid-email":
        _util.showErrorMessage("Erro", "E-mail é inválido.");
        break;
      case "email-already-in-use":
        _util.showErrorMessage("Erro", "E-mail já cadastrado.");
        break;
      case "invalid-credential":
        _util.showErrorMessage("Erro", "Email inválido.");
        break;
      default:
        _util.showErrorMessage(
          "Erro",
          "Erro desconhecido, tente novamente mais tarde ou entre em contato com nosso e-mail: appsiteat@gmail.com",
        );
    }
  }
}
