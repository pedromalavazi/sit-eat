import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/reservation_controller.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';
import 'package:sit_eat/app/data/services/restaurant_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';

class RestaurantController extends GetxController {
  final RestaurantService _restaurantService = RestaurantService();
  final ReservationService _reservationService = ReservationService();
  final TextEditingController idUserTextController = TextEditingController();
  final TextEditingController qtdMesaTextController = TextEditingController();
  UserModel currentUser = AuthService.to.user.value;

  String restaurantId = Get.arguments;
  Rx<RestaurantModel> restaurant = RestaurantModel().obs;
  RxString openTimeFormat = "".obs;
  RxString closeTimeFormat = "".obs;
  RxBool isOpen = false.obs;
  RxString userName = "".obs;
  UserModel user = UserModel();
  RxBool hideButton = true.obs;

  @override
  void onInit() async {
    setObsUser();
    getRestaurant();
    super.onInit();
  }

  void setObsUser() {
    user = currentUser;
    userName.value = currentUser.name;
    idUserTextController.text = currentUser.id;
  }

  void getRestaurant() async {
    RestaurantModel currentRestaurant = await _restaurantService.get(restaurantId);
    restaurant.value = currentRestaurant;
    setTimes();
    setButtonState();
  }

  void registerReservation() async {
    int qtdMesa = int.parse(qtdMesaTextController.text);

    String reservationId = await _reservationService.insert(idUserTextController.text, restaurantId, qtdMesa);

    var retorno = await _reservationService.insertIdReservation(reservationId, restaurantId);
    if (retorno) {
      Get.snackbar(
        "Sucesso",
        "Reserva realizada com sucesso...",
        colorText: Colors.black,
        backgroundColor: Colors.grey[600],
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.info, color: Colors.white),
        shouldIconPulse: true,
      );
    } else {
      Get.snackbar(
        "Error",
        "Não foi possível realizar a reserva!",
        colorText: Colors.white,
        backgroundColor: Colors.red[400],
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error, color: Colors.white),
        shouldIconPulse: true,
      );
    }
  }

  void setTimes() {
    var openDateTime = DateTime.fromMillisecondsSinceEpoch(restaurant.value.openTime.millisecondsSinceEpoch);
    openTimeFormat.value = _restaurantService.convertDateTimeToHourFormat(
      openDateTime,
    );

    var closeDateTime = DateTime.fromMillisecondsSinceEpoch(restaurant.value.closeTime.millisecondsSinceEpoch);
    closeTimeFormat.value = _restaurantService.convertDateTimeToHourFormat(
      closeDateTime,
    );

    setOpenOrClosed(openDateTime, closeDateTime);
  }

  void setOpenOrClosed(DateTime openTime, DateTime closeTime) {
    isOpen.value = _restaurantService.verifyIsOpen(openTime, closeTime);
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

  void launchURLBrowser(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Nao foi possivel abrir $url';
    }
  }

  void setButtonState() {
    if (isOpen.value) {
      hideButton.value = false;
    }
  }
}
