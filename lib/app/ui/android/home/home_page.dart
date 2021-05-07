import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sit_eat/app/controller/home_controller.dart';
import 'package:sit_eat/app/data/model/user_model.dart';
import 'package:sit_eat/app/ui/android/home/widgets/restaurant_card.dart';

class HomePage extends GetView<HomeController> {
  final UserModel user;
  HomePage({this.user});

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.put(HomeController(this.user));

    return Scaffold(
      backgroundColor: Colors.red[50],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
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
                        backgroundColor: Colors.red,
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
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        hintText: "Pesquisar restaurantes",
                        border: InputBorder.none),
                  ),
                ),
              ),
              // Lista de restaurantes
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _homeController.restaurants.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RestaurantCard(
                        restaurant: _homeController.restaurants[index],
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
