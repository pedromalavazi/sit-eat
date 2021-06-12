import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtilService extends GetxService {
  showErrorMessage(String title, String message) {
    return Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.red[400],
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 4),
      icon: Icon(Icons.error, color: Colors.white),
      shouldIconPulse: true,
    );
  }

  showInformationMessage(String title, String message) {
    return Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.grey[500],
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
      icon: Icon(Icons.info, color: Colors.white),
    );
  }

  showSuccessMessage(String title, String message) {
    return Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.grey[500],
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
      icon: Icon(Icons.done_rounded, color: Colors.white),
      shouldIconPulse: true,
    );
  }

  showLoader() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: Colors.red,
          strokeWidth: 3.5,
        ),
      ),
      barrierDismissible: false,
    );
  }
}
