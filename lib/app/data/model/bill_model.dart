import 'package:cloud_firestore/cloud_firestore.dart';

class BillModel {
  String id;
  double total;
  bool paid;

  BillModel({
    this.id,
    this.total,
    this.paid,
  });

  BillModel.fromSnapshot(DocumentSnapshot bill)
      : id = bill.id,
        total = bill.data()["total"],
        paid = bill.data()["paid"];
}
