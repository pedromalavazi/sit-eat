import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/reservation_model.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class ReservationCard extends StatelessWidget {
  final ReservationModel reservation;
  ReservationCard({this.reservation});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Cards reservas
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.RESTAURANT_WAIT_PAGE, arguments: reservation.id);
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
                      image: NetworkImage(
                        "https://yummmy.s3.amazonaws.com/uploads/image/file/86274/regular_perfil-rei-dos-lanches--1-.png",
                        //restaurant.image.isEmpty ? 'https://yummmy.s3.amazonaws.com/uploads/image/file/86274/regular_perfil-rei-dos-lanches--1-.png' : restaurant.image,
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
                        "teste",
                        //restaurant.name,
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
                            reservation.occupationQty.toString(),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.people,
                            size: 24,
                            color: Colors.black,
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
    );
  }
}
