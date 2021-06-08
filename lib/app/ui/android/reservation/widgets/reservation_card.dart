import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/reservation_card_model.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ReservationCard extends StatelessWidget {
  final ReservationCardModel reservation;
  ReservationCard({this.reservation});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Cards reservas
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.RESTAURANT_WAIT_PAGE, arguments: reservation);
        },
        child: Opacity(
          opacity: reservation.status == 'Reservado' ? 1 : 0.5,
          child: Card(
            shadowColor: Colors.grey,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: reservation.status == 'Reservado' ? Colors.white : Colors.grey.shade300,
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
                        image: NetworkImage(
                          reservation.restaurantImage.isEmpty ? 'https://yummmy.s3.amazonaws.com/uploads/image/file/86274/regular_perfil-rei-dos-lanches--1-.png' : reservation.restaurantImage,
                        ),
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
                          reservation.restaurantName,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Lugares: " + reservation.occupationQty.toString(),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              reservation.status,
                              style: TextStyle(
                                fontSize: 20,
                                color: reservation.status == 'Reservado' ? Colors.green : Colors.red,
                              ),
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