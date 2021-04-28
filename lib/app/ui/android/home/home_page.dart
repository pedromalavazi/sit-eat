import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/home_controller.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/ui/android/home/widgets/restaurant_card.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[50],
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  // Header Perfil
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Olá,",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black54),
                                ),
                                Obx(
                                  () => Text(
                                    _homeController.userName.value,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                          CircleAvatar(
                            radius: 35,
                          )
                        ],
                      )),

                  // Barra de pesquisa
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // position
                          ),
                        ],
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              top: 15,
                              right: 20,
                              bottom: 15,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: CircleAvatar(
                                child: Icon(Icons.search),
                              ),
                            ),
                            hintText: "Pesquisar restaurantes",
                            border: InputBorder.none),
                      ),
                    ),
                  ),

                  // LISTA DE RESTAURANTES
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        RestaurantCard(),
                        RestaurantCard(),
                        RestaurantCard(),
                        RestaurantCard()
                      ],
                    ),
                  )),
                ]))));
  }
}
