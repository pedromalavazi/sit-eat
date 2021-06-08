import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel {
  String id;
  String userId;
  String restaurantId;
  Timestamp checkIn;
  int occupationQty;
  bool active;
  bool canceled;

  ReservationModel({
    this.id,
    this.userId,
    this.restaurantId,
    this.checkIn,
    this.occupationQty,
    this.active,
    this.canceled,
  });

  ReservationModel.fromSnapshot(DocumentSnapshot reservation)
      : id = reservation.data()["id"],
        userId = reservation.data()["userId"],
        restaurantId = reservation.data()["restaurantId"],
        checkIn = reservation.data()["checkin"],
        occupationQty = reservation.data()["occupationQty"],
        active = reservation.data()["active"],
        canceled = reservation.data()["canceled"];
}
