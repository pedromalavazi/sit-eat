import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/reservation_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';
import 'package:sit_eat/app/data/services/restaurant_service.dart';

class ReservationController extends GetxController {
  //final RestaurantService _restaurantService = RestaurantService();
  final ReservationService _reservationService = ReservationService();

  String restaurantId = Get.arguments;
  Rx<ReservationModel> reservation = ReservationModel().obs;
  RxList<ReservationModel> allReservations = RxList<ReservationModel>();
  Rx<UserModel> user = UserModel().obs;

  @override
  void onReady() async {
    setUser();
    getAllReservations(user);
    super.onReady();
  }

  setUser() {
    user = AuthService.to.user;
  }

  void getReservation() async {
    ReservationModel currentRestaurant = await _reservationService.get(restaurantId);
    reservation.value = currentRestaurant;
  }

  void getAllReservations(user) async {
    var reservationsFromBase = await _reservationService.getAll();
    allReservations.addAll(reservationsFromBase);
  }

  Widget setRestaurantImage(String image) {
    if (GetUtils.isNullOrBlank(image)) {
      return Container(
        child: Image.asset("assets/logo-only.png"),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }
}
