import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/data/model/restaurant_model.dart';
import 'package:sit_eat/app/routes/app_pages.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;
  RestaurantCard({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Cards restaurantes
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.RESTAURANT, arguments: restaurant.id);
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
                        restaurant.image.isEmpty ? 'https://yummmy.s3.amazonaws.com/uploads/image/file/86274/regular_perfil-rei-dos-lanches--1-.png' : restaurant.image,
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
                        restaurant.name,
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
                            restaurant.capacity.toString(),
                            style: Theme.of(context).textTheme.bodyText2,
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
