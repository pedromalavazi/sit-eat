import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/enum/reservation_status_enum.dart';
import 'package:sit_eat/app/data/model/reservation_card_model.dart';
import 'package:sit_eat/app/data/services/reservation_service.dart';
import 'package:intl/intl.dart';
import 'package:sit_eat/app/data/services/util_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ReservationWaitController extends GetxController {
  final UtilService _util = UtilService();
  final ReservationService _reservationService = ReservationService();
  ReservationCardModel reservationCardModel = Get.arguments;
  Rx<ReservationCardModel> reservation = ReservationCardModel().obs;
  Rx<ReservationStatus> status = ReservationStatus.RESERVADO.obs;

  RxString checkInHour = "".obs;
  RxString checkInDate = "".obs;
  RxInt occupationQty = 0.obs;
  RxString position = "".obs;

  @override
  void onInit() {
    getReservationDetails(reservationCardModel);
    getQueuePosition();
    super.onInit();
  }

  void getReservationDetails(ReservationCardModel reservation) {
    this.reservation.value = reservation;
    occupationQty.value = reservation.occupationQty;
    status.value = reservation.status;

    var checkInConverted = DateTime.fromMillisecondsSinceEpoch(reservation.checkIn.millisecondsSinceEpoch);
    checkInHour.value = DateFormat.Hm().format(checkInConverted);
    checkInDate.value = DateFormat('dd/MM/yyyy').format(checkInConverted);
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

  getQueuePosition() async {
    try {
      _reservationService.listenerReservationsFromQueue(reservationCardModel.restaurantId, reservationCardModel.userId).listen((event) async {
        var tempPosition = await _reservationService.getPositionInQueue(event, reservationCardModel.userId);
        if (tempPosition == 0) {
          status.value = ReservationStatus.AGUARDANDO;
        }
        position.value = tempPosition.toString();
      });
    } catch (error) {}
  }

  void cancelReservation() async {
    var success = await _reservationService.cancelReservation(reservation.value.id, reservation.value.restaurantId);
    if (success) {
      Get.back();
      _util.showInformationMessage("Sucesso", "Reserva cancelada com sucesso!");
    }
  }
}
