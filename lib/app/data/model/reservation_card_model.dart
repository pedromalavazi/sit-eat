import 'package:cloud_firestore/cloud_firestore.dart';

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
  bool active;
  bool canceled;
  String status;

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
    this.active,
    this.canceled,
    this.status,
  });
}
