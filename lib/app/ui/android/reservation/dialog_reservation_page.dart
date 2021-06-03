import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/reservation_controller.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class DialogReservationPage extends GetView<ReservationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar mesa'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "SALVAR",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('Foi'),
      ),
    );
  }
}
