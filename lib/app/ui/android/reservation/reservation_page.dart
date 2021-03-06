import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/reservation_controller.dart';
import 'package:sit_eat/app/ui/android/reservation/widgets/reservation_card.dart';

class ReservationPage extends GetView<ReservationController> {
  @override
  Widget build(BuildContext context) {
    final ReservationController _reservationController = Get.find<ReservationController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Reservas"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              // Lista de reservas
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _reservationController.allReservations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ReservationCard(
                        reservation: _reservationController.allReservations[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
