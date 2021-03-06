import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/qr_code_model.dart';

class QrCodeRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Retorna um restaurant pelo QR Code
  Future<QrCodeModel> getByQrCode(String qrCode) async {
    try {
      QrCodeModel qrCodeModel = QrCodeModel();
      await _firestore
          .collection('qrCodes')
          .where('qrCode', isEqualTo: qrCode)
          .get()
          .then((QuerySnapshot doc) => {
                if (doc.docs.length > 0)
                  {
                    qrCodeModel = QrCodeModel.fromSnapshot(doc.docs.first),
                  }
                else
                  {
                    qrCodeModel = null,
                  }
              });

      return qrCodeModel;
    } catch (e) {
      Get.defaultDialog(
          title: "ERROR", content: Text("QrCode não encontrado."));
      return null;
    }
  }
}
