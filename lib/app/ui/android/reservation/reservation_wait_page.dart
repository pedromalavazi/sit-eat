import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/controller/login_controller.dart';
import 'package:sit_eat/app/controller/reservation_controller.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';

class ReservationWaitPage extends GetView<LoginController> {
  final ReservationController _reservationController = Get.find<ReservationController>();

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
                        child: _reservationController.setRestaurantImage(_reservationController.restaurant.value.image),
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
                                _reservationController.restaurant.value.address ?? "",
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
                                _reservationController.restaurant.value.name ?? "",
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
                            Text(
                              "Horário de Check-in: ",
                              //+ _reservationController.restaurant.value.name ?? "",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Lugares: ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Lugar na fila: ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80,
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
