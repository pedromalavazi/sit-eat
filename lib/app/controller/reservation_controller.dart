import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/reservation_model.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';
import 'package:sit_eat/app/data/services/restaurant_service.dart';

class ReservationController extends GetxController {
  final ReservationService _reservationService = ReservationService();
  final RestaurantService _restaurantService = RestaurantService();

  String restaurantId = Get.arguments;
  RxList<ReservationModel> allReservations = RxList<ReservationModel>();
  RxList<ReservationModel> reservations = RxList<ReservationModel>();
  Rx<ReservationModel> reservation = ReservationModel().obs;
  Rx<RestaurantModel> restaurant = RestaurantModel().obs;
  Rx<UserModel> user = UserModel().obs;

  RxString checkIn = "".obs;
  RxInt occupationQty = 0.obs;

  @override
  void onInit() {
    super.onInit();
    setUser();
    getAllReservations(user.value.id);
  }

  setUser() {
    user = AuthService.to.user;
  }

  void getReservation() async {
    ReservationModel currentRestaurant = await _reservationService.get(restaurantId);
    reservation.value = currentRestaurant;
  }

  void getAllReservations(String userId) async {
    var reservationsFromBase = await _reservationService.getAll(user.value.id);
    allReservations.addAll(reservationsFromBase);
    reservations.addAll(allReservations);
  }

  void getRestaurantProps(String id) async {
    RestaurantModel currentRestaurant = await _restaurantService.get(restaurantId);
    restaurant.value = currentRestaurant;
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
