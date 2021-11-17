import 'package:cloud_firestore/cloud_firestore.dart';

class BillModel {
  String id;
  String reservationId;
  bool asked;
  bool paid;
  double total;

  BillModel({this.id, this.reservationId, this.asked, this.paid, this.total});

  BillModel.fromSnapshot(DocumentSnapshot bill)
      : id = bill.id,
        reservationId = bill.data()["reservationId"],
        asked = bill.data()["asked"],
        paid = bill.data()["paid"],
        total = bill.data()["total"];

  Map<String, dynamic> toJson() {
    return {"id": id, "reservationId": reservationId, "asked": asked, "paid": paid, "total": total};
  }
}
