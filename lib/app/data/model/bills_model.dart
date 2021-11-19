import 'package:cloud_firestore/cloud_firestore.dart';

class BillModel {
  String id;
  String reservationId;
  bool asked;
  bool paid;
  double total;
  String paymentType;

  BillModel(
      {this.id,
      this.reservationId,
      this.asked,
      this.paid,
      this.total,
      this.paymentType});

  BillModel.fromSnapshot(DocumentSnapshot bill)
      : id = bill.id,
        reservationId = bill.data()["reservationId"],
        asked = bill.data()["asked"],
        paid = bill.data()["paid"],
        total = bill.data()["total"],
        paymentType = bill.data()["paymentType"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "reservationId": reservationId,
      "asked": asked,
      "paid": paid,
      "total": total,
      "paymentType": paymentType
    };
  }
}
