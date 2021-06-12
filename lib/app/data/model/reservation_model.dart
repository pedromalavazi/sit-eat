import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_eat/app/data/model/enum/reservation_status_enum.dart';

class ReservationModel {
  String id;
  String userId;
  String restaurantId;
  Timestamp checkIn;
  int occupationQty;
  ReservationStatus status;

  ReservationModel({
    this.id,
    this.userId,
    this.restaurantId,
    this.checkIn,
    this.occupationQty,
    this.status,
  });

  ReservationModel.fromSnapshot(DocumentSnapshot reservation)
      : id = reservation.id,
        userId = reservation.data()["userId"],
        restaurantId = reservation.data()["restaurantId"],
        checkIn = reservation.data()["checkin"],
        occupationQty = reservation.data()["occupationQty"],
        status = ReservationStatus.values.where((status) => status.toUpper == reservation.data()["status"]).first;
}

List<ReservationModel> convertReservationsFromDB(QuerySnapshot reservationsFromDB) {
  List<ReservationModel> reservations = <ReservationModel>[];
  reservationsFromDB.docs.forEach((restaurant) {
    reservations.add(ReservationModel.fromSnapshot(restaurant));
  });
  return reservations;
}
