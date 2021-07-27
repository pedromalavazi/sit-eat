import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_eat/app/data/model/enum/qr_code_type_enum.dart';

class QrCodeModel {
  String id;
  String qrCode;
  String referenceId;
  QrCodeType type;

  QrCodeModel({this.id, this.qrCode, this.referenceId, this.type});

  QrCodeModel.fromSnapshot(DocumentSnapshot qrCode)
      : id = qrCode.data()["id"],
        qrCode = qrCode.data()["qrCode"],
        referenceId = qrCode.data()["referenceId"],
        type = QrCodeType.values
            .where((status) => status.toUpper == qrCode.data()["type"])
            .first;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "qrCode": qrCode,
      "referenceId": referenceId,
      "type": type
    };
  }
}
