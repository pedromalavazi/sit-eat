import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationCardModel {
  String id;
  String userId;
  String restaurantId;
  String restaurantName;
  String restaurantImage;
  Timestamp checkIn;
  int occupationQty;
  bool active;
  bool canceled;
  String address;
  String menu;

  ReservationCardModel({
    this.id,
    this.userId,
    this.restaurantId,
    this.checkIn,
    this.occupationQty,
    this.active,
    this.canceled,
    this.restaurantImage,
    this.restaurantName,
    this.address,
    this.menu,
  });
}
