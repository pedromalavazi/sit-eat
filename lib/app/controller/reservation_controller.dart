import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/reservation_model.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';
import 'package:sit_eat/app/data/services/restaurant_service.dart';

class ReservationController extends GetxController {
  final RestaurantService _restaurantService = RestaurantService();
  final ReservationService _reservationService = ReservationService();
  UserModel currentUser = AuthService.to.user.value;
  ReservationModel reservation = ReservationModel();
  final TextEditingController qtdMesaTextController = TextEditingController();
  final TextEditingController idUserTextController = TextEditingController();

  String restaurantId = Get.arguments;
  Rx<RestaurantModel> restaurant = RestaurantModel().obs;
  RxString userName = "".obs;
  UserModel user = UserModel();

  @override
  void onReady() async {
    setObsUser();
    getRestaurant();
    super.onReady();
  }

  void getRestaurant() async {
    RestaurantModel currentRestaurant =
        await _restaurantService.get(restaurantId);
    restaurant.value = currentRestaurant;
  }

  void setObsUser() {
    user = currentUser;
    userName.value = currentUser.name;
    idUserTextController.text = currentUser.id;
  }

  void registerReservation() async {
    int qtdMesa = int.parse(qtdMesaTextController.text);

    String reservationId = await _reservationService.insert(
        idUserTextController.text, restaurantId, qtdMesa);

    await _reservationService.insertIdReservation(reservationId, restaurantId);
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
