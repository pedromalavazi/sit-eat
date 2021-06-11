import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/controller/reservation_wait_controller.dart';
import 'package:sit_eat/app/data/model/reservation_card_model.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';

// Pagina interna da reserva (ao abrir card do restaurante)
class ReservationWaitPage extends GetView<ReservationWaitController> {
  final ReservationCardModel reservation;
  ReservationWaitPage({this.reservation});

  final ReservationWaitController _reservationWaitController = Get.put(ReservationWaitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[500],
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.red,
              Colors.red[400],
              Colors.red[300],
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Obx(
                    () => Center(
                      child: SizedBox(
                        width: 140,
                        height: 120,
                        child: _reservationWaitController.setRestaurantImage(_reservationWaitController.reservation.value.restaurantImage),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                _reservationWaitController.reservation.value.address ?? "",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Text(
                                _reservationWaitController.reservation.value.restaurantName ?? "",
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Text(
                                "Data: " + _reservationWaitController.checkInDate.value,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Text(
                                "Hora: " + _reservationWaitController.checkInHour.value,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Text(
                                "Lugares: " + _reservationWaitController.reservation.value.occupationQty.toString() ?? "",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Column(
                          children: [
                            Obx(
                              () => _reservationWaitController.position.value == "0"
                                  ? Text(
                                      "Mesa disponível!",
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.green,
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Text(
                                          "Lugar na fila",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.green,
                                          ),
                                        ),
                                        Text(
                                          _reservationWaitController.position.value,
                                          style: TextStyle(
                                            fontSize: 60,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ButtonWidget(
                              isWhiteTheme: false,
                              onPressed: () {
                                _reservationWaitController.launchURLBrowser(_reservationWaitController.reservation.value.menu);
                              },
                              text: "Menu",
                              height: 60,
                              width: 180,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ButtonWidget(
                              isWhiteTheme: true,
                              onPressed: () {},
                              text: "Cancelar reserva",
                              height: 60,
                              width: 180,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
