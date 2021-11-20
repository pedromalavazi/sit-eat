import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/enum/reservation_status_enum.dart';
import 'package:sit_eat/app/data/model/reservation_card_model.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';
import 'package:sit_eat/app/data/services/restaurant_service.dart';

class ReservationController extends GetxController {
  final ReservationService _reservationService = ReservationService();
  final RestaurantService _restaurantService = RestaurantService();

  RxList<ReservationCardModel> allReservations = RxList<ReservationCardModel>();
  Rx<UserModel> user = UserModel().obs;
  RxString paymentType = "".obs;
  RxBool billAsked = false.obs;

  @override
  void onInit() {
    user = AuthService.to.user;
    getAllReservations(user.value.id);
    super.onInit();
  }

  Future<RestaurantModel> getRestaurantProps(String restaurantId) async {
    RestaurantModel currentRestaurant = await _restaurantService.get(restaurantId);
    return currentRestaurant;
  }

  void getAllReservations(String userId) async {
    _reservationService.listenerReservations(userId).listen((reservations) async {
      allReservations.clear();
      reservations = _reservationService.sortReservationsByCheckIn(reservations).reversed.toList();

      List<ReservationCardModel> tempAllReservations = <ReservationCardModel>[];
      for (var i = 0; i < reservations.length; i++) {
        var reservation = reservations[i];
        ReservationCardModel cardTemp = ReservationCardModel();
        var restaurantTemp = await getRestaurantProps(reservation.restaurantId);
        cardTemp.id = reservation.id;
        cardTemp.checkIn = reservation.checkIn;
        cardTemp.occupationQty = reservation.occupationQty;
        cardTemp.restaurantId = reservation.restaurantId;
        cardTemp.restaurantImage = restaurantTemp.image;
        cardTemp.restaurantName = restaurantTemp.name;
        cardTemp.userId = reservation.userId;
        cardTemp.address = restaurantTemp.address;
        cardTemp.menu = restaurantTemp.menu;
        cardTemp.status = reservation.status;
        tempAllReservations.add(cardTemp);
      }
      this.allReservations.addAll(tempAllReservations);
    });
  }

  double getStatusOpacity(ReservationStatus status) {
    if (status == ReservationStatus.RESERVADO || status == ReservationStatus.AGUARDANDO) {
      return 1;
    }
    return 0.5;
  }

  Color getStatusColor(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.RESERVADO:
        return Colors.green;
      case ReservationStatus.AGUARDANDO:
        return Colors.amber[700];
      case ReservationStatus.ATIVO:
        return Colors.blue;
      case ReservationStatus.FINALIZADO:
        return Colors.grey[800];
      case ReservationStatus.CANCELADO:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  Color getCardColor(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.FINALIZADO:
        return Colors.grey[300];
      case ReservationStatus.CANCELADO:
        return Colors.grey[300];
      default:
        return Colors.white;
    }
  }
}
