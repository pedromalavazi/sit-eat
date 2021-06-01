import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sit_eat/app/routes/app_pages.dart';

class ReservationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservas'),
        centerTitle: true,
      ),
      body: Container(
        // Cards restaurantes
        child: GestureDetector(
          onTap: () {
            // ID MOCKADO
            Get.toNamed(Routes.RESTAURANT_WAIT_PAGE, arguments: "3Z9aUNeTGR2jwAL5RdTg");
          },
          child: Card(
            shadowColor: Colors.grey,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              //EdgeInsets.symmetric(horizontal: 26.0, vertical: 36),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // Logo image restaurante
                      image: DecorationImage(
                        image: NetworkImage('https://yummmy.s3.amazonaws.com/uploads/image/file/86274/regular_perfil-rei-dos-lanches--1-.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Nome do restaurante
                        Text(
                          "Nome restaurante",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Capacidade
                            Text(
                              //getstatus de reserva (reservado/finalizado)
                              "Reservado / Finalizado",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              width: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
