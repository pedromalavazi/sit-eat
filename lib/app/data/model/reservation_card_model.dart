import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_eat/app/data/model/enum/reservation_status_enum.dart';

class ReservationCardModel {
  String id;
  String userId;
  String restaurantId;
  String restaurantName;
  String restaurantImage;
  Timestamp checkIn;
  int occupationQty;
  String address;
  String menu;
  ReservationStatus status;

  ReservationCardModel({
    this.id,
    this.userId,
    this.restaurantId,
    this.checkIn,
    this.occupationQty,
    this.restaurantImage,
    this.restaurantName,
    this.address,
    this.menu,
    this.status,
  });
}
