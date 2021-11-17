import 'package:cloud_firestore/cloud_firestore.dart';

class TableModel {
  String id;
  bool busy;
  int capacity;
  int number;
  String reservationid;
  String qrCode;

  TableModel({
    this.id,
    this.busy,
    this.capacity,
    this.number,
    this.reservationid,
    this.qrCode,
  });

  TableModel.fromSnapshot(DocumentSnapshot table)
      : id = table.id,
        busy = table.data()["busy"],
        capacity = table.data()["capacity"],
        number = table.data()["number"],
        reservationid = table.data()["reservationid"],
        qrCode = table.data()["qrCode"];
}
