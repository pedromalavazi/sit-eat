import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/util_service.dart';

class ImageService extends GetxService {
  final UtilService _utilService = UtilService();
  var storage = FirebaseStorage.instance;

  final String _loggedUserId = AuthService.to.user.value.id;
  final String _restaurantURL = 'gs://sit-eat-84d56.appspot.com/restaurants';
  final String _productURL = 'gs://sit-eat-84d56.appspot.com/products';
  final String _usersURL = 'gs://sit-eat-84d56.appspot.com/users';
  final String _defaultImage = 'default.png';

  Future<String> downloadRestaurantUrl(
    String photoUrl,
    String restaurantId,
  ) async {
    String image;
    try {
      if (restaurantId == null) return "";

      image = await storage
          .refFromURL('$_restaurantURL/$restaurantId')
          .child(photoUrl)
          .getDownloadURL();
    } catch (e) {
      image = await storage
          .refFromURL('$_restaurantURL')
          .child(_defaultImage)
          .getDownloadURL();
    }
    return image;
  }

  Future<String> downloadProductUrl(
    String photoUrl,
    String restaurantId,
  ) async {
    String image;
    try {
      if (restaurantId == null) return "";

      image = await storage
          .refFromURL('$_productURL/$restaurantId')
          .child(photoUrl)
          .getDownloadURL();
    } catch (e) {
      image = await storage
          .refFromURL('$_productURL')
          .child(_defaultImage)
          .getDownloadURL();
    }
    return image;
  }

  Future<String> downloadUserUrl(String photoUrl) async {
    String image;
    try {
      if (_loggedUserId == null) return "";

      image = await storage
          .refFromURL('$_usersURL/$_loggedUserId')
          .child(photoUrl)
          .getDownloadURL();
    } catch (e) {
      image = await storage
          .refFromURL('$_usersURL')
          .child(_defaultImage)
          .getDownloadURL();
    }
    return image;
  }

  Future<bool> uploadUserImage(XFile data) async {
    try {
      var file = File(data.path);
      await storage
          .refFromURL('$_usersURL/$_loggedUserId')
          .child(data.name)
          .putFile(file);

      return true;
    } catch (e) {
      _utilService.showErrorMessage("Erro", "Erro ao salvar a imagem.");
      return false;
    }
  }
}
