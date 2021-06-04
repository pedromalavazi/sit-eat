import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/reservation_controller.dart';
import 'package:sit_eat/app/ui/android/widgets/input_field.dart';

class RegisterReservationPage extends GetView<ReservationController> {
  final ReservationController _reservationController =
      Get.find<ReservationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar mesa'),
        // centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              _reservationController.registerReservation();
            },
            child: Text(
              "SALVAR",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            InputField(
              controller: _reservationController.qtdMesaTextController,
              labelText: "Quantidade de pessoas",
              textInputType: TextInputType.number,
              validator: (value) {
                if (GetUtils.isNullOrBlank(value)) {
                  return "Campo obrigatório";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
