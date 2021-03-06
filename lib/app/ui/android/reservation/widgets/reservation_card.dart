import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/reservation_controller.dart';
import 'package:sit_eat/app/data/model/enum/reservation_status_enum.dart';
import 'package:sit_eat/app/data/model/reservation_card_model.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ReservationCard extends StatelessWidget {
  final ReservationCardModel reservation;
  ReservationCard({this.reservation});

  final ReservationController _reservationController =
      Get.find<ReservationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // Cards reservas
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.RESTAURANT_WAIT_PAGE, arguments: reservation);
        },
        child: Opacity(
          opacity: _reservationController.getStatusOpacity(reservation.status),
          child: Card(
            shadowColor: Colors.grey,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: _reservationController.getCardColor(reservation.status),
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
                        image: NetworkImage(reservation.restaurantImage),
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
                              "Lugares: " +
                                  reservation.occupationQty.toString(),
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
                              reservation.status.description,
                              style: TextStyle(
                                fontSize: 20,
                                color: _reservationController
                                    .getStatusColor(reservation.status),
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
